import 'package:user_chat_app/bloc/sign_up/sign_up_status.dart';

class SignUpState {
  final String username;
  final String usermail;
  final String password;
  final LoginProcessStatus status;

  SignUpState({
    this.username = '',
    this.usermail = '',
    this.password = '',
    this.status = const LoginInitialStatus(),
  });

  SignUpState copyWith({
    String? username,
    String? usermail,
    String? password,
    LoginProcessStatus? status,
  }) {
    return SignUpState(
      usermail: usermail ?? this.usermail,
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
