class CryptoCurrency {
  String? name;
  String? coin;
  String? remainAmount;
  List<Chains>? chains;

  CryptoCurrency({this.name, this.coin, this.remainAmount, this.chains});

  CryptoCurrency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    coin = json['coin'];
    remainAmount = json['remainAmount'];
    if (json['chains'] != null) {
      chains = <Chains>[];
      json['chains'].forEach((v) {
        chains!.add(new Chains.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['coin'] = this.coin;
    data['remainAmount'] = this.remainAmount;
    if (this.chains != null) {
      data['chains'] = this.chains!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chains {
  String? chainType;
  String? confirmation;
  String? withdrawFee;
  String? depositMin;
  String? withdrawMin;
  String? chain;
  String? chainDeposit;
  String? chainWithdraw;
  String? minAccuracy;
  String? withdrawPercentageFee;

  Chains(
      {this.chainType,
      this.confirmation,
      this.withdrawFee,
      this.depositMin,
      this.withdrawMin,
      this.chain,
      this.chainDeposit,
      this.chainWithdraw,
      this.minAccuracy,
      this.withdrawPercentageFee});

  Chains.fromJson(Map<String, dynamic> json) {
    chainType = json['chainType'];
    confirmation = json['confirmation'];
    withdrawFee = json['withdrawFee'];
    depositMin = json['depositMin'];
    withdrawMin = json['withdrawMin'];
    chain = json['chain'];
    chainDeposit = json['chainDeposit'];
    chainWithdraw = json['chainWithdraw'];
    minAccuracy = json['minAccuracy'];
    withdrawPercentageFee = json['withdrawPercentageFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chainType'] = this.chainType;
    data['confirmation'] = this.confirmation;
    data['withdrawFee'] = this.withdrawFee;
    data['depositMin'] = this.depositMin;
    data['withdrawMin'] = this.withdrawMin;
    data['chain'] = this.chain;
    data['chainDeposit'] = this.chainDeposit;
    data['chainWithdraw'] = this.chainWithdraw;
    data['minAccuracy'] = this.minAccuracy;
    data['withdrawPercentageFee'] = this.withdrawPercentageFee;
    return data;
  }
}
