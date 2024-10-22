abstract class CreateContactFailure implements Exception {
  String? get message;
  String? get code;
  get data;
}

class CreateContactRequestError implements CreateContactFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  CreateContactRequestError({this.message, this.code, this.data});
}

class CreateContactUnauthorizedError implements CreateContactFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  CreateContactUnauthorizedError({this.message, this.code, this.data});
}

class CreateContactForbiddenError implements CreateContactFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  CreateContactForbiddenError({this.message, this.code, this.data});
}

class CreateContactInternalError implements CreateContactFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  CreateContactInternalError({this.message, this.code, this.data});
}

class CreateContactUnkownError implements CreateContactFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  CreateContactUnkownError({this.message, this.code, this.data});
}
