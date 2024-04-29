abstract class SignInEvent {}

class OnUseremailChanged extends SignInEvent {
  final String email;
  OnUseremailChanged(this.email);
}

class OnUserPasswordChanged extends SignInEvent {
  final String password;
  OnUserPasswordChanged(this.password);
}

class OnSignInBtnClicked extends SignInEvent {}
