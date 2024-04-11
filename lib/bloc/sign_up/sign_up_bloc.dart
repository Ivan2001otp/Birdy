import 'package:user_chat_app/bloc/sign_up/sign_up_event.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_status.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<onSignUpBtnClicked>((event, emit) async {
      Future.delayed(
        Duration(seconds: 2),
      );

      emit(
        state.copyWith(
          status: LoginSuccessStatus("Success"),
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
