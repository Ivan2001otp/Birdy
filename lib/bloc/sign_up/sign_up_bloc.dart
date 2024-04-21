import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_event.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

        if (userCredential != null) {
          bool res = await _firestoreCloudService.saveSignedUpUser(
              state.username,
              state.usermail,
              state.password,
              userCredential.user!.uid);

          if (res) {
            emit(
              state.copyWith(status: const LoginSuccessStatus()),
            );
          } else {
            emit(
              state.copyWith(
                  status: const LoginFailureStatus(
                      'Not able to save record in firestore Cloud!')),
            );
          }
        }
      } catch (error, stackTrace) {
        print("Stack trace is --> ${stackTrace.toString}");
        print("Error is ---> ${error.toString}");
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
