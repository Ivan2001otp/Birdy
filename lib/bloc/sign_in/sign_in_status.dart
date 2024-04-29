abstract class SignInStatus {
  const SignInStatus();
}

class SignInInitialStatus extends SignInStatus {
  const SignInInitialStatus();
}

class SignInSuccessStatus extends SignInStatus {
  const SignInSuccessStatus();
}

class SignInFailureStatus extends SignInStatus {
  final String message;
  const SignInFailureStatus(this.message);
}

class SignInLoadingStatus extends SignInStatus {
  const SignInLoadingStatus();
}
