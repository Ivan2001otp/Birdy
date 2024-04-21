import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_chat_app/Models/UserInfo.dart' as Us;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_event.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_state.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_status.dart';
import 'package:user_chat_app/services/cloud_firestore.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  FirestoreCloud _firestoreCloudService = FirestoreCloud();

  SignUpBloc() : super(SignUpState()) {
    on<onSignUpBtnClicked>((event, emit) async {
      emit(
        state.copyWith(
          status: const LoginLoadingStatus(),
        ),
      );

      //create acc with password and email...
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: state.usermail, password: state.password);

        await _firestoreCloudService.saveSignedUpUser(state.username,
            state.usermail, state.password, userCredential.user!.uid);

        Us.UserInfo userInfo = Us.UserInfo(
            name: state.username, uniqueId: userCredential.user!.uid);
        //write in cloudfirestore to save the user...
        await _firestoreCloudService.saveLoggedInorSignedInUser(userInfo);

        emit(
          state.copyWith(status: const LoginSuccessStatus()),
        );
      } catch (error, stackTrace) {
        print("Stack trace is --> ${stackTrace.toString()}");
        print("Error is ---> ${error.toString()}");
        emit(
          state.copyWith(
            status: const LoginFailureStatus("Sign up error"),
          ),
        );
      }

      emit(
        state.copyWith(
          status: const LoginSuccessStatus(),
        ),
      );
    });

    on<onUserEmailChange>((event, emit) async {
      emit(
        state.copyWith(
          usermail: event.email,
        ),
      );
    });

    on<onUserNameChange>((event, emit) async {
      emit(
        state.copyWith(
          username: event.username,
        ),
      );
    });

    on<onUserPasswordChange>((event, emit) async {
      emit(
        state.copyWith(
          password: event.password,
        ),
      );
    });
  }
}
