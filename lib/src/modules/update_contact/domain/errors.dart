abstract class UpdateContactFailure implements Exception {
  String? get message;
  String? get code;
  get data;
}

class UpdateContactRequestError implements UpdateContactFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  UpdateContactRequestError({this.message, this.code, this.data});
}

class UpdateContactUnauthorizedError implements UpdateContactFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  UpdateContactUnauthorizedError({this.message, this.code, this.data});
}

class UpdateContactForbiddenError implements UpdateContactFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  UpdateContactForbiddenError({this.message, this.code, this.data});
}

class UpdateContactInternalError implements UpdateContactFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  UpdateContactInternalError({this.message, this.code, this.data});
}

class UpdateContactUnkownError implements UpdateContactFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  UpdateContactUnkownError({this.message, this.code, this.data});
}
