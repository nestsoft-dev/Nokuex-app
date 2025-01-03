class UserBankModel {
  String? sId;
  String? userid;
  String? bankcode;
  String? accountNumber;
  String? bankname;
  String? account_name;
  String? createAt;
  int? iV;

  UserBankModel(
      {this.sId,
      this.userid,
      this.bankcode,
      this.accountNumber,
      this.bankname,
      this.createAt,
    this.account_name,
      this.iV});

  UserBankModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userid = json['userid'];
    bankcode = json['bankcode'];
    accountNumber = json['account_number'];
    bankname = json['bankname'];
    account_name = json['account_name'];
    createAt = json['createAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userid'] = this.userid;
    data['bankcode'] = this.bankcode;
    data['account_number'] = this.accountNumber;
    data['bankname'] = this.bankname;
    data['createAt'] = this.createAt;
    data['account_name'] = this.account_name;
    data['__v'] = this.iV;
    return data;
  }
}
