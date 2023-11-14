class ApiResponse<T> {
  ApiReqStatus status;
  T? data;
  String? message;
  ApiResponse.loading({required this.message}) : status = ApiReqStatus.loading;
  ApiResponse.success({required this.data, this.status = ApiReqStatus.success});
  ApiResponse.error({required this.message}) : status = ApiReqStatus.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiReqStatus { loading, success, error }
