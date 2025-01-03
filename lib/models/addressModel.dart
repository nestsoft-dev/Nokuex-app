class CoinAddress {
  final String coin;
  final ChainAddress chain;

  CoinAddress({
    required this.coin,
    required this.chain,
  });

  // Factory constructor to create a Coin object from JSON
  factory CoinAddress.fromJson(Map<String, dynamic> json) {
    return CoinAddress(
      coin: json['coin'] as String,
      chain: ChainAddress.fromJson(json['chains'] as Map<String, dynamic>),
    );
  }

  // Method to convert a Coin object to JSON
  Map<String, dynamic> toJson() {
    return {
      'coin': coin,
      'chains': chain.toJson(),
    };
  }
}

class ChainAddress {
  final String chainType;
  final String addressDeposit;
  final String tagDeposit;
  final String chain;
  final String batchReleaseLimit;

  ChainAddress({
    required this.chainType,
    required this.addressDeposit,
    this.tagDeposit = '',
    required this.chain,
    required this.batchReleaseLimit,
  });

  // Factory constructor to create a Chain object from JSON
  factory ChainAddress.fromJson(Map<String, dynamic> json) {
    return ChainAddress(
      chainType: json['chainType'] as String,
      addressDeposit: json['addressDeposit'] as String,
      tagDeposit: json['tagDeposit'] as String? ?? '',
      chain: json['chain'] as String,
      batchReleaseLimit: json['batchReleaseLimit'] as String,
    );
  }

  // Method to convert a Chain object to JSON
  Map<String, dynamic> toJson() {
    return {
      'chainType': chainType,
      'addressDeposit': addressDeposit,
      'tagDeposit': tagDeposit,
      'chain': chain,
      'batchReleaseLimit': batchReleaseLimit,
    };
  }
}
