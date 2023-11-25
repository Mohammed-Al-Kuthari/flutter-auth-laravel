class ConnectivityExption implements Exception {
  final String message;

  const ConnectivityExption(this.message);

  String getMessage() => message;
}
