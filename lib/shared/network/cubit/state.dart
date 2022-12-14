abstract class NetworkStates {
  const NetworkStates();
}

class NoErrorState extends NetworkStates {}

class SocketErrorState extends NetworkStates {
  final String error;

  const SocketErrorState(this.error);
}

class ClientErrorState extends NetworkStates {
  final String error;

  const ClientErrorState(this.error);
}

class ServerErrorState extends NetworkStates {
  final String error;

  const ServerErrorState(this.error);
}

class UnauthenticatedState extends NetworkStates {
  final String error;

  UnauthenticatedState(this.error);
}

class ErrorState extends NetworkStates {
  final String error;

  const ErrorState(this.error);
}
