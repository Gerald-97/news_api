class ServiceResponse<T> {
  late bool status;
  final T? data;
  final String? message;

  ServiceResponse(
      {this.data,
      this.message,
      required this.status,});

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
