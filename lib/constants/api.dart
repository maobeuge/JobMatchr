class ResponseModel {
  final int? statusCode;
  final String? sentence;
  final dynamic content;

  const ResponseModel({this.statusCode, this.sentence, this.content});
}
