class CryptoData {
  String? fullName;
  String? shortName;
  String? iconUrl;
  String? currentMarketPrice;
  String? increasePercentage;
  bool? hasIncreased;

  CryptoData(
      {this.fullName,
      this.shortName,
      this.iconUrl,
      this.currentMarketPrice,
      this.increasePercentage,
      this.hasIncreased});

  CryptoData.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    shortName = json['shortName'];
    iconUrl = json['iconUrl'];
    currentMarketPrice = json['currentMarketPrice'];
    increasePercentage = json['increasePercentage'];
    hasIncreased = json['hasIncreased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['shortName'] = this.shortName;
    data['iconUrl'] = this.iconUrl;
    data['currentMarketPrice'] = this.currentMarketPrice;
    data['increasePercentage'] = this.increasePercentage;
    data['hasIncreased'] = this.hasIncreased;
    return data;
  }
}
