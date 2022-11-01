class ServiceResponse<T> {
  late bool status;
  final T? data;
  final String? message;
  final bool notAuthenticated;

  ServiceResponse(
      {this.data,
      this.message,
      this.failure,
      required this.status,
      this.notAuthenticated = false});

  NotifierState<T> toNotifierState() {
    return status
        ? notifyRight<T>(data: data, message: message)
        : notifyError<T>(
            error: message ?? "Something went wrong",
            noAuth: notAuthenticated,
          );
  }

  @override
  String toString() {
    return 'ServiceResponse{status: $status, data: $data, message: $message}';
  }
}
