class AuthResponse {
  AuthResponse({
      this.message, 
      this.error, 
      this.profileData, 
      this.acYear,});

  AuthResponse.fromJson(dynamic json) {
    message = json['message'];
    error = json['error'];
    if (json['ProfileData'] != null&&!error!) {
      profileData = [];
      json['ProfileData'].forEach((v) {
        profileData?.add(ProfileData.fromJson(v));
      });
    }
    if (json['AcYear'] != null&&!error!) {
      acYear = [];
      json['AcYear'].forEach((v) {
        acYear?.add(AcYear.fromJson(v));
      });
    }
  }
  String? message;
  bool? error;
  List<ProfileData>? profileData;
  List<AcYear>? acYear;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['error'] = error;
    if (profileData != null) {
      map['ProfileData'] = profileData?.map((v) => v.toJson()).toList();
    }
    if (acYear != null) {
      map['AcYear'] = acYear?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AcYear {
  AcYear({
      this.acYear,});

  AcYear.fromJson(dynamic json) {
    acYear = json['AcYear'];
  }
  String? acYear;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AcYear'] = acYear;
    return map;
  }

}

class ProfileData {
  ProfileData({
      this.customerID, 
      this.regMobileNo, 
      this.regEmailID, 
      this.membersType, 
      this.userID, 
      this.userName, 
      this.loginSessionID, 
      this.iDCardNumber, 
      this.isApproved, 
      this.profileComplite, 
      this.totalFileUploaded, 
      this.totalKYCFiles, 
      this.directorDone, 
      this.totalDirectorsKYC, 
      this.totalCalcelledCheques, 
      this.totalBuyers,});

  ProfileData.fromJson(dynamic json) {
    customerID = json['CustomerID'];
    regMobileNo = json['RegMobileNo'];
    regEmailID = json['RegEmailID'];
    membersType = json['MembersType'];
    userID = json['UserID'];
    userName = json['UserName'];
    loginSessionID = json['LoginSessionID'];
    iDCardNumber = json['IDCardNumber'];
    isApproved = json['IsApproved'];
    profileComplite = json['ProfileComplite'];
    totalFileUploaded = json['TotalFileUploaded'];
    totalKYCFiles = json['TotalKYCFiles'];
    directorDone = json['DirectorDone'];
    totalDirectorsKYC = json['TotalDirectorsKYC'];
    totalCalcelledCheques = json['TotalCalcelledCheques'];
    totalBuyers = json['TotalBuyers'];
    MembersAccountType = json['MembersAccountType'];
    points="";
  }
  String? MembersAccountType;
  String? customerID;
  String? regMobileNo;
  String? regEmailID;
  String? membersType;
  dynamic userID;
  String? userName;
  String? loginSessionID;
  String? iDCardNumber;
  bool? isApproved;
  int? profileComplite;
  int? totalFileUploaded;
  int? totalKYCFiles;
  int? directorDone;
  int? totalDirectorsKYC;
  int? totalCalcelledCheques;
  int? totalBuyers;
  String? points;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CustomerID'] = customerID;
    map['RegMobileNo'] = regMobileNo;
    map['RegEmailID'] = regEmailID;
    map['MembersType'] = membersType;
    map['UserID'] = userID;
    map['UserName'] = userName;
    map['LoginSessionID'] = loginSessionID;
    map['IDCardNumber'] = iDCardNumber;
    map['IsApproved'] = isApproved;
    map['ProfileComplite'] = profileComplite;
    map['TotalFileUploaded'] = totalFileUploaded;
    map['TotalKYCFiles'] = totalKYCFiles;
    map['DirectorDone'] = directorDone;
    map['TotalDirectorsKYC'] = totalDirectorsKYC;
    map['TotalCalcelledCheques'] = totalCalcelledCheques;
    map['TotalBuyers'] = totalBuyers;
    map['MembersAccountType'] = MembersAccountType;
    return map;
  }

}