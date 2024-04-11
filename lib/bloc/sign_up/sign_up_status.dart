abstract class LoginProcessStatus {
  const LoginProcessStatus();
}

class LoginInitialStatus extends LoginProcessStatus {
  const LoginInitialStatus();
}

class LoginLoadingStatus extends LoginProcessStatus {
  final String loadingMessage;
  const LoginLoadingStatus(this.loadingMessage);
}

class LoginSuccessStatus extends LoginProcessStatus {
  final String message;
  const LoginSuccessStatus(this.message);
}

class LoginFailureStatus extends LoginProcessStatus {
  final String error;
  final Exception exception;

  const LoginFailureStatus(this.error, this.exception);
}
