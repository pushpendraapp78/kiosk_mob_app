import '../../../model/user_detail.dart';

class SignupResponse {
  SignupResponse({
      this.success, 
      this.successCode, 
      this.message, 
      this.data,});

  SignupResponse.fromJson(dynamic json) {
    success = json['success'];
    successCode = json['success_code'];
    message = json['message'];
    data = json['data'] != null ? UserDetail.fromJson(json['data']) : null;
  }
  bool? success;
  int? successCode;
  String? message;
  UserDetail? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['success_code'] = successCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

