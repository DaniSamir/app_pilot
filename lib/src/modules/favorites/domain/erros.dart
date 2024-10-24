abstract class FavoritesFailure implements Exception {
  String? get message;
  String? get code;
  get data;
}

class FavoritesRequestError implements FavoritesFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  FavoritesRequestError({this.message, this.code, this.data});
}

class FavoritesUnauthorizedError implements FavoritesFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  FavoritesUnauthorizedError({this.message, this.code, this.data});
}

class FavoritesForbiddenError implements FavoritesFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  FavoritesForbiddenError({this.message, this.code, this.data});
}

class FavoritesInternalError implements FavoritesFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  FavoritesInternalError({this.message, this.code, this.data});
}

class FavoritesUnkownError implements FavoritesFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  FavoritesUnkownError({this.message, this.code, this.data});
}
