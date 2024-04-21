abstract class HomeStatus {
  const HomeStatus();
}

class HomeInitialStatus extends HomeStatus {
  const HomeInitialStatus();
}

class HomeLoadingStatus extends HomeStatus {
  final String message;
  const HomeLoadingStatus({
    required this.message,
  });
}

class HomeFailureStatus extends HomeStatus {
  const HomeFailureStatus();
}

class HomeSuccessStatus extends HomeStatus {
  const HomeSuccessStatus();
}
