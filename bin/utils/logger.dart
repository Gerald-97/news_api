import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

Logger logger = Logger();

void logResponse(http.Response response) {
  logger.i("${response.request!.url}\n"
      "${response.statusCode} : ${response.reasonPhrase}\n"
      "${response.body}\n");
}

void logPrint(Object? object) {
  logger.i(object);
}

void logSocketException(SocketException error) {
  logger.wtf("${error.address} \t ${error.port}\n"
      "${error.message}");
}

void logTimeoutException(TimeoutException error) {
  logger.e("${error.duration} \t ${error.message}");
}
