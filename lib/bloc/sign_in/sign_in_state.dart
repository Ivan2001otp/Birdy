import 'package:user_chat_app/bloc/sign_in/sign_in_status.dart';

class SignInState {
  final String userEmail;
  final String password;
  final SignInStatus status;

  SignInState({
    this.userEmail = '',
    this.password = '',
    this.status = const SignInInitialStatus(),
  });

  SignInState copyWith({
    String? userEmail,
    String? password,
    SignInStatus? status,
  }) {
    return SignInState(
      userEmail: userEmail ?? this.userEmail,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
