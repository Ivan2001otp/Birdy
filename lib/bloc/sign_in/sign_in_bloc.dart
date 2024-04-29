import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_chat_app/bloc/sign_in/sign_in_event.dart';
import 'package:user_chat_app/bloc/sign_in/sign_in_state.dart';
import 'package:user_chat_app/bloc/sign_in/sign_in_status.dart';
import 'package:user_chat_app/services/cloud_firestore.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    FirestoreCloud _firestoreCloudService = FirestoreCloud();

    on<OnSignInBtnClicked>(
      (event, emit) async {
        emit(state.copyWith(
          status: const SignInLoadingStatus(),
        ));

        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: state.userEmail,
            password: state.password,
          );

          emit(
            state.copyWith(
              status: const SignInSuccessStatus(),
            ),
          );
        } catch (error, stackTrace) {
          print("Stack trace is --> ${stackTrace.toString()}");
          print("Error is ---> ${error.toString()}");
          emit(
            state.copyWith(
              status: const SignInFailureStatus("Sign up error"),
            ),
          );
        }
      },
    );

    on<OnUserPasswordChanged>(
      (event, emit) async {
        emit(
          state.copyWith(
            password: event.password,
          ),
        );
      },
    );

    on<OnUseremailChanged>(
      (event, emit) async {
        emit(
          state.copyWith(
            userEmail: event.email,
          ),
        );
      },
    );
  }
}
