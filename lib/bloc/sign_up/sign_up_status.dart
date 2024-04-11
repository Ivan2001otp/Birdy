abstract class LoginProcessStatus {
  const LoginProcessStatus();
}

class LoginInitialStatus extends LoginProcessStatus {
  const LoginInitialStatus();
}

class LoginLoadingStatus extends LoginProcessStatus {
  const LoginLoadingStatus();
}

class LoginSuccessStatus extends LoginProcessStatus {
  const LoginSuccessStatus();
}

class LoginFailureStatus extends LoginProcessStatus {
  final String exception;

  const LoginFailureStatus(this.exception);
}
