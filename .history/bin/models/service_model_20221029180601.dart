class ServiceResponse<T> {
  late bool status;
  final T? data;
  final String? message;

  ServiceResponse(
      {this.data,
      this.message,
      required this.status,});

  @override
  String toString() {
    return 'ServiceResponse{status: $status, data: $data, message: $message}';
  }
}
