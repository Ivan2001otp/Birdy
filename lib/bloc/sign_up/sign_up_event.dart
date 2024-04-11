import 'package:user_chat_app/view/signup_page.dart';

abstract class SignUpEvent {}

class onUserPasswordChange extends SignUpEvent {
  final String password;
  onUserPasswordChange(this.password);
}

class onUserEmailChange extends SignUpEvent {
  final String email;
  onUserEmailChange(this.email);
}

class onUserNameChange extends SignUpEvent {
  final String username;
  onUserNameChange(this.username);
}

class onSignUpBtnClicked extends SignUpEvent {}
