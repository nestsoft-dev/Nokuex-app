class User {
  final String id; // Non-nullable, but initialize to an empty string if not provided
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String referralCode;
  final String phone;
  final String password; // Consider encrypting or omitting this in actual usage
  final double nairaBalance;
  final double dollarBalance;
  final bool isVerified;
  final bool smsNotification;
  final bool emailNotification;
  final bool twoFA;
  final String twoFACode;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.username = '',
    required this.email,
    required this.referralCode,
    required this.phone,
    required this.password,
    this.nairaBalance = 0.0,
    this.dollarBalance = 0.0,
    this.isVerified = false,
    this.smsNotification = false,
    this.emailNotification = false,
    this.twoFA = false,
    this.twoFACode = '',
  });

  // Factory constructor to create a User from a JSON object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String? ?? '', // Default empty string if null
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      username: json['username'] as String? ?? '',
      email: json['email'] as String,
      referralCode: json['referralcode'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      nairaBalance: (json['nairabalance'] as num?)?.toDouble() ?? 0.0,
      dollarBalance: (json['dollarbalance'] as num?)?.toDouble() ?? 0.0,
      isVerified: json['verify'] as bool? ?? false,
      smsNotification: json['smsnotification'] as bool? ?? false,
      emailNotification: json['emailnotification'] as bool? ?? false,
      twoFA: json['twofa'] as bool? ?? false,
      twoFACode: json['twofacode'] as String? ?? '',
    );
  }

  // Method to convert User object to JSON object
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'referralcode': referralCode,
      'phone': phone,
      'password': password, // Handle securely
      'nairabalance': nairaBalance,
      'dollarbalance': dollarBalance,
      'verify': isVerified,
      'smsnotification': smsNotification,
      'emailnotification': emailNotification,
      'twofa': twoFA,
      'twofacode': twoFACode,
    };
  }
}
