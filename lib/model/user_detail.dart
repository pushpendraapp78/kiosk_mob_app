class UserDetail {
  UserDetail({
    this.name,
    this.email,
    this.otp,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  UserDetail.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    otp = json['otp'];
    mobile = json['mobile'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }
  String? name;
  String? email;
  String? mobile;
  dynamic otp;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['otp'] = otp;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    map['token'] = token;
    return map;
  }
}
