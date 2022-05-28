class MResponse {
  String? responseMessage;

  MResponse({
    this.responseMessage,
  });

  factory MResponse.fromJson(Map<String, dynamic> map) {
    return MResponse(responseMessage: map["message"]);
  }
}

responseData(Map<String, dynamic> jsonData) {
  return MResponse.fromJson(jsonData);
}
