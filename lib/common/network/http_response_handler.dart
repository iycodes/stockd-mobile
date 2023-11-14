import 'package:dio/dio.dart';

class HttpResponseHandler implements Exception {
  final String? _message;
  final ResponseBody _context;

  HttpResponseHandler(this._message, this._context, statusCode);

  String stringify() {
    return "message: $_message \n fullError: $_context";
  }
}

class HttpErrorNotFound extends HttpResponseHandler {
  final String? msg;

  @override
  HttpErrorNotFound(
      {required context,
      this.msg = "Data was not found on server",
      statuscode = 404})
      : super(msg, context, statuscode);
}

class HttpErrorBadRequest extends HttpResponseHandler {
  final String? msg;

  @override
  HttpErrorBadRequest(
      {required context,
      this.msg = "Bad request or Invalid details or data sent",
      statuscode = 400})
      : super(msg, context, statuscode);
}

class HttpErrorUnauthorized extends HttpResponseHandler {
  final String? msg;

  @override
  HttpErrorUnauthorized(
      {required context, this.msg = "Unauthorized", statuscode = 401})
      : super(msg, context, statuscode);
}

class HttpErrorForbidden extends HttpResponseHandler {
  final String? msg;

  @override
  HttpErrorForbidden(
      {required context, this.msg = "internal server error", statuscode = 403})
      : super(msg, context, statuscode);
}

class HttpErrorServerError extends HttpResponseHandler {
  final String? msg;

  @override
  HttpErrorServerError(
      {required context, this.msg = "internal server error", statuscode = 500})
      : super(msg, context, statuscode);
}

class HttpErrorCustomError extends HttpResponseHandler {
  final String? msg;

  @override
  HttpErrorCustomError(
      {required context,
      this.msg = "Something went Wrong",
      required statuscode})
      : super(msg, context, statuscode);
}
