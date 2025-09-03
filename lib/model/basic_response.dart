
class BasicResponse {
  BasicResponse({
      this.success, 
      this.successCode, 
      this.message});

  BasicResponse.fromJson(dynamic json) {
    success = json['success']??false;
    successCode = json['success_code'];
    message = json['message'];
  }
  bool? success;
  int? successCode;
  String? message;


}

