class DocumentResponse {
  bool? success;
  int? successCode;
  String? message;
  List<Data>? data;

  DocumentResponse({
    this.success,
    this.successCode,
    this.message,
    this.data,
  });

  DocumentResponse.fromJson(dynamic json) {
    success = json['success'];
    successCode = json['success_code'] ?? json['status']; // some APIs send status instead
    message = json['message'];

    // handle nested "data" -> "data" structure
    if (json['data'] != null) {
      if (json['data'] is Map && json['data']['data'] != null) {
        data = [];
        json['data']['data'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      } else if (json['data'] is List) {
        // fallback in case API sometimes returns plain list
        data = [];
        json['data'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['success_code'] = successCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  int? id;
  String? file;
  String? pageType;
  String? printType;
  dynamic noOfCopies;
  String? transactionsId;
  dynamic amount;
  String? otp;
  String? otp_status;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.file,
    this.pageType,
    this.printType,
    this.noOfCopies,
    this.transactionsId,
    this.amount,
    this.otp,
    this.otp_status,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    file = json['file'];
    pageType = json['page_type'];
    printType = json['print_type'];
    noOfCopies = json['no_of_copies'];
    transactionsId = json['transactions_id'];
    amount = json['amount'];
    otp = json['otp'];
    otp_status = json['otp_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['file'] = file;
    map['page_type'] = pageType;
    map['print_type'] = printType;
    map['no_of_copies'] = noOfCopies;
    map['transactions_id'] = transactionsId;
    map['amount'] = amount;
    map['otp'] = otp;
    map['otp_status'] = otp_status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
