abstract class ContactListFailure implements Exception {
  String? get message;
  String? get code;
  get data;
}

class ContactListRequestError implements ContactListFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  ContactListRequestError({this.message, this.code, this.data});
}

class ContactListUnauthorizedError implements ContactListFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  ContactListUnauthorizedError({this.message, this.code, this.data});
}

class ContactListForbiddenError implements ContactListFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  ContactListForbiddenError({this.message, this.code, this.data});
}

class ContactListInternalError implements ContactListFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  ContactListInternalError({this.message, this.code, this.data});
}

class ContactListUnkownError implements ContactListFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  ContactListUnkownError({this.message, this.code, this.data});
}
