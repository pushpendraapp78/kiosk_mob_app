class AmountResponse {
  AmountResponse({
      this.success, 
      this.successCode, 
      this.message, 
      this.data,});

  AmountResponse.fromJson(dynamic json) {
    success = json['success'];
    successCode = json['success_code'];
    message = json['message'];
    data = json['data']['value'];
  }
  bool? success;
  int? successCode;
  String? message;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['success_code'] = successCode;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}