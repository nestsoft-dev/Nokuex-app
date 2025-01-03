class CryptoCurrency {
  final String fullName;
  final String shortName;
  final List<Chain> chains;

  CryptoCurrency({
    required this.fullName,
    required this.shortName,
    required this.chains,
  });

  // Factory constructor to create an instance from JSON
  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
      fullName: json['fullName'] as String,
      shortName: json['shortName'] as String,
      chains: (json['chains'] as List<dynamic>)
          .map((e) => Chain.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'shortName': shortName,
      'chains': chains.map((e) => e.toJson()).toList(),
    };
  }
}

class Chain {
  final String chainType;
  final String confirmation;
  final String withdrawFee;
  final String depositMin;
  final String withdrawMin;
  final String chain;
  final String chainDeposit;
  final String chainWithdraw;
  final String minAccuracy;
  final String withdrawPercentageFee;

  Chain({
    required this.chainType,
    required this.confirmation,
    this.withdrawFee = '',
    required this.depositMin,
    this.withdrawMin = '',
    required this.chain,
    required this.chainDeposit,
    required this.chainWithdraw,
    required this.minAccuracy,
    this.withdrawPercentageFee = '',
  });

  // Factory constructor to create an instance from JSON
  factory Chain.fromJson(Map<String, dynamic> json) {
    return Chain(
      chainType: json['chainType'] as String,
      confirmation: json['confirmation'] as String,
      withdrawFee: json['withdrawFee'] as String? ?? '',
      depositMin: json['depositMin'] as String,
      withdrawMin: json['withdrawMin'] as String? ?? '',
      chain: json['chain'] as String,
      chainDeposit: json['chainDeposit'] as String,
      chainWithdraw: json['chainWithdraw'] as String,
      minAccuracy: json['minAccuracy'] as String,
      withdrawPercentageFee: json['withdrawPercentageFee'] as String? ?? '',
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'chainType': chainType,
      'confirmation': confirmation,
      'withdrawFee': withdrawFee,
      'depositMin': depositMin,
      'withdrawMin': withdrawMin,
      'chain': chain,
      'chainDeposit': chainDeposit,
      'chainWithdraw': chainWithdraw,
      'minAccuracy': minAccuracy,
      'withdrawPercentageFee': withdrawPercentageFee,
    };
  }
}
