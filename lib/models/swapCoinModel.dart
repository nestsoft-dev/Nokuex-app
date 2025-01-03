class SwapCoinModel {
  String? coin;
  String? fullName;
  String? icon;
  String? iconNight;
  int? accuracyLength;
  String? coinType;
  String? balance;
  String? uBalance;
  int? timePeriod;
  String? singleFromMinLimit;
  String? singleFromMaxLimit;
  String? singleToMinLimit;
  String? singleToMaxLimit;
  String? dailyFromMinLimit;
  String? dailyFromMaxLimit;
  String? dailyToMinLimit;
  String? dailyToMaxLimit;
  bool? disableFrom;
  bool? disableTo;

  SwapCoinModel(
      {this.coin,
      this.fullName,
      this.icon,
      this.iconNight,
      this.accuracyLength,
      this.coinType,
      this.balance,
      this.uBalance,
      this.timePeriod,
      this.singleFromMinLimit,
      this.singleFromMaxLimit,
      this.singleToMinLimit,
      this.singleToMaxLimit,
      this.dailyFromMinLimit,
      this.dailyFromMaxLimit,
      this.dailyToMinLimit,
      this.dailyToMaxLimit,
      this.disableFrom,
      this.disableTo});

  SwapCoinModel.fromJson(Map<String, dynamic> json) {
    coin = json['coin'];
    fullName = json['fullName'];
    icon = json['icon'];
    iconNight = json['iconNight'];
    accuracyLength = json['accuracyLength'];
    coinType = json['coinType'];
    balance = json['balance'];
    uBalance = json['uBalance'];
    timePeriod = json['timePeriod'];
    singleFromMinLimit = json['singleFromMinLimit'];
    singleFromMaxLimit = json['singleFromMaxLimit'];
    singleToMinLimit = json['singleToMinLimit'];
    singleToMaxLimit = json['singleToMaxLimit'];
    dailyFromMinLimit = json['dailyFromMinLimit'];
    dailyFromMaxLimit = json['dailyFromMaxLimit'];
    dailyToMinLimit = json['dailyToMinLimit'];
    dailyToMaxLimit = json['dailyToMaxLimit'];
    disableFrom = json['disableFrom'];
    disableTo = json['disableTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coin'] = this.coin;
    data['fullName'] = this.fullName;
    data['icon'] = this.icon;
    data['iconNight'] = this.iconNight;
    data['accuracyLength'] = this.accuracyLength;
    data['coinType'] = this.coinType;
    data['balance'] = this.balance;
    data['uBalance'] = this.uBalance;
    data['timePeriod'] = this.timePeriod;
    data['singleFromMinLimit'] = this.singleFromMinLimit;
    data['singleFromMaxLimit'] = this.singleFromMaxLimit;
    data['singleToMinLimit'] = this.singleToMinLimit;
    data['singleToMaxLimit'] = this.singleToMaxLimit;
    data['dailyFromMinLimit'] = this.dailyFromMinLimit;
    data['dailyFromMaxLimit'] = this.dailyFromMaxLimit;
    data['dailyToMinLimit'] = this.dailyToMinLimit;
    data['dailyToMaxLimit'] = this.dailyToMaxLimit;
    data['disableFrom'] = this.disableFrom;
    data['disableTo'] = this.disableTo;
    return data;
  }
}
