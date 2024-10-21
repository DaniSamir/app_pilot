class AppPilotoResponse {
  AppPilotoResponse(
      {required this.data,
      required this.statusCode,
      required this.statusMessage,
      required this.realUri,
      required this.headers});
  final dynamic data;
  final int statusCode;
  final Uri realUri;
  final Map<String, dynamic> headers;
  String statusMessage;
}
