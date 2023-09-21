import 'package:flutter_application_1/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.complected(this.data) : status = Status.COMPLECTED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  String toString() {
    return "Status : $status \n Message : $message \n Data:$data";
  }
}
