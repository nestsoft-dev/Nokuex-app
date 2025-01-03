class CoinBalance {
  String? coin;
  String? transferBalance;
  String? walletBalance;
  String? bonus;
  String? marketRate;
  String? nairaBalance;

  CoinBalance(
      {this.coin,
      this.transferBalance,
      this.walletBalance,
      this.bonus,
      this.marketRate,
      this.nairaBalance});

  CoinBalance.fromJson(Map<String, dynamic> json) {
    coin = json['coin'];
    transferBalance = json['transferBalance'];
    walletBalance = json['walletBalance'];
    bonus = json['bonus'];
    marketRate = json['marketRate'];
    nairaBalance = json['nairaBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coin'] = this.coin;
    data['transferBalance'] = this.transferBalance;
    data['walletBalance'] = this.walletBalance;
    data['bonus'] = this.bonus;
    data['marketRate'] = this.marketRate;
    data['nairaBalance'] = this.nairaBalance;
    return data;
  }
}
