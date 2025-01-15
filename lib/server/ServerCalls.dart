import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:nokuex/models/addressModel.dart';
import 'package:nokuex/models/bankModel.dart';
import 'package:nokuex/models/cryptoData.dart';
import 'package:nokuex/models/myCoinModel.dart';
import 'package:nokuex/models/supportedCoin.dart';
import 'package:nokuex/models/swapCoinModel.dart';
import 'package:nokuex/models/userBankModel.dart';
import 'package:nokuex/models/userModel.dart';
import 'package:nokuex/views/Auth/recovery/newPasswordPage.dart';
import 'package:nokuex/views/Auth/recovery/verifyDetails.dart';
import 'package:nokuex/views/NavPage/NavPage.dart';
import 'package:nokuex/views/utils/myToast.dart';
import 'package:nokuex/views/utils/passcodeInput.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = StateProvider<User?>((ref) => null);

final loadingProvider = StateProvider<bool>((ref) => false);

final coinlistProvider = FutureProvider<List<CryptoData>>((ref) async {
  List<CryptoData> crytodataList = [];
  try {
    final String url = dotenv.get('URL', fallback: '');
    if (url.isEmpty) {
      throw Exception("URL not found or empty in environment variables");
    }
    final response = await http.get(Uri.parse('$url/api/crypto/coin-feed'));
    var data = jsonDecode(response.body);
    print(response.body.toString());

    if (response.statusCode == 200) {
      List<dynamic> _datalist = data['data'];
      crytodataList =
          _datalist.map((element) => CryptoData.fromJson(element)).toList();
      return crytodataList;
    } else {
      throw Exception('error');
    }
  } catch (e) {
    throw Exception('No Data found');
  }
});

//get swappable coin list
final swappableCoinListProvider =
    FutureProvider<List<SwapCoinModel>>((ref) async {
  List<SwapCoinModel> coinList = [];
  try {
    final String url = dotenv.get('URL', fallback: '');
    if (url.isEmpty) {
      throw Exception("URL not found or empty in environment variables");
    }

    final respones = await http.get(
      Uri.parse('$url/api/crypto/get-convertable-coin-list'),
    );
    print(respones.body.toString());
    var data = jsonDecode(respones.body);
    if (respones.statusCode == 200) {
      final List<dynamic> list = data['data']['result']['coins'];
      coinList = list
          .map((e) => SwapCoinModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      errorToast(data['message']);
    }
  } on SocketException catch (e) {
    errorToast('No Internet connection');
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
  return coinList;
});

final usersBankListProvider = FutureProvider<List<UserBankModel?>>((ref) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final String? token = pref.getString('token');
  if (token == null || token.isEmpty) {
    throw Exception("Token not found or empty");
  }

  final String url = dotenv.get('URL', fallback: '');
  if (url.isEmpty) {
    throw Exception("URL not found or empty in environment variables");
  }

  List<UserBankModel?> bank = [];
  try {
    final respones = await http.get(
      Uri.parse('$url/api/banks/get-banks/$token'),
    );
    print(respones.body.toString());
    var data = jsonDecode(respones.body);
    if (respones.statusCode == 200) {
      final List<dynamic> list = data['data'];
      bank = list
          .map((e) => UserBankModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      errorToast(data['message']);
    }
  } on SocketException catch (e) {
    errorToast('No Internet connection');
  } catch (e) {
    errorToast('No Internet connection');
  }

  return bank;
});

final usersCoinProvider = StateProvider<List<CoinBalance>>((ref) => []);

Stream<List<CoinBalance>> getCoinBalanceStream() async* {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final String? token = pref.getString('token');

  if (token == null || token.isEmpty) {
    throw Exception("Token not found or empty");
  }

  final String url = dotenv.get('URL', fallback: '');
  if (url.isEmpty) {
    throw Exception("URL not found or empty in environment variables");
  }

  try {
    while (true) {
      final response =
          await http.get(Uri.parse('$url/api/crypto/all-mycoins/$token'));
      print(response.body.toString() + '--------');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true && data['data'] != null) {
          final List<dynamic> list = data['data'];
          final List<CoinBalance> listCoin = list
              .map((e) => CoinBalance.fromJson(e as Map<String, dynamic>))
              .toList();

          yield listCoin; // Emit the list of coin balances
        } else {
          throw Exception('Failed to fetch coins: ${data['message']}');
        }
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }

      await Future.delayed(
          const Duration(seconds: 30)); // Poll every 30 seconds
    }
  } on SocketException {
    throw Exception('No Internet connection');
  } catch (e) {
    throw Exception('An unexpected error occurred: ');
  }
}

final coinBalanceStreamProvider = StreamProvider<List<CoinBalance>>((ref) {
  return getCoinBalanceStream();
});

final banklistProvider = FutureProvider<List<BankListModel>>((ref) async {
  final String url = dotenv.get('URL', fallback: '');
  if (url.isEmpty) {
    throw Exception("URL not found or empty in environment variables");
  }

  List<BankListModel> listCoin = [];
  try {
    final response = await http.get(
      Uri.parse(
          'https://uitlhxiazg.execute-api.ap-southeast-1.amazonaws.com/api/banks/bank-list'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(response.body);

      if (data['data'] != null) {
        final List<dynamic> list = data['data'];
        listCoin = list
            .map((e) => BankListModel.fromJson(e as Map<String, dynamic>))
            .toList();
        listCoin.sort((a, b) => a.name!.compareTo(b.name!));
      }
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to fetch coins: ${response.body}');
    }
  } on SocketException {
    print('No Internet connection');
    errorToast('No Internet connection');
  } catch (e) {
    print('Error: $e');
    throw Exception('An unexpected error occurred: $e');
  }

  return listCoin;
});

final allCoinListProvider = FutureProvider<List<CryptoCurrency>>((ref) async {
  final String url = dotenv.get('URL', fallback: '');
  if (url.isEmpty) {
    throw Exception("URL not found or empty in environment variables");
  }

  List<CryptoCurrency> listCoin = [];
  try {
    final response = await http.get(
      Uri.parse('$url/api/crypto/all-coins'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(response.body);

      if (data['status'] == true && data['data'] != null) {
        final List<dynamic> list = data['data'];
        listCoin = list
            .map((e) => CryptoCurrency.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to fetch coins: ${response.body}');
    }
  } on SocketException {
    print('No Internet connection');
    throw Exception('No Internet connection');
  } catch (e) {
    print('Error: $e');
    throw Exception('An unexpected error occurred: $e');
  }

  return listCoin;
});

final coinAddressProvider = StateProvider<CoinAddress?>((ref) => null);

class Servercalls {
  String url = dotenv.get('URL');
  var header = {
    //'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<CoinBalance>> getCoinBalance(
      BuildContext context, WidgetRef ref) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception("Token not found or empty");
    }

    final String url = dotenv.get('URL', fallback: '');
    if (url.isEmpty) {
      throw Exception("URL not found or empty in environment variables");
    }

    try {
      final response =
          await http.get(Uri.parse('$url/api/crypto/all-mycoins/$token'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(response.body);

        if (data['status'] == true && data['data'] != null) {
          final List<dynamic> list = data['data'];
          final List<CoinBalance> listCoin = list
              .map((e) => CoinBalance.fromJson(e as Map<String, dynamic>))
              .toList();

          // Update provider state
          ref.read(usersCoinProvider.notifier).state = listCoin;
          return listCoin;
        } else {
          throw Exception('Failed to fetch coins: ${data['message']}');
        }
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    } on SocketException {
      print('No Internet connection');
      errorToast('No Internet connection');
      throw Exception('No Internet connection');
    } catch (e) {
      print('Error: $e');
      throw Exception('An unexpected error occurred: ');
    }
  }

  Future<User?> getUserDetails(BuildContext context, WidgetRef ref) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    String url = dotenv.get('URL');
    if (kDebugMode) {
      print(token);
    }
    try {
      final response = await http.get(
        Uri.parse('$url/api/user/get-user/$token'),
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(data['data']);
        ref.read(userProvider.notifier).state = user;
        return user;
      }
    } on SocketException catch (e) {
      print(e.toString());
      errorToast('No Internet');
    } catch (e) {
      errorToast('Something went wrong');
    }
  }

  Future<void> verifyEmailorPhone(
      String email,
      final String phone,
      final String firstname,
      final String lastname,
      BuildContext context,
      PageController pageController) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      var body = jsonEncode({'email': email});
      print(body);
      final response = await http.post(
          Uri.parse('$url/api/user/verify-email-or-phone'),
          body: jsonDecode(body),
          headers: header);
      var data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 200) {
        final tokenid = data['tokenid'];
        pref.setString('email', email);
        pref.setString('tokenid', tokenid);
        pref.setString('firstname', firstname);
        pref.setString('lastname', lastname);
        pref.setString('phonenumber', phone);

        pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linearToEaseOut);
      } else {
        errorToast(data['message']);
      }
    } on SocketException catch (e) {
      errorToast('No Internet connection');
    } catch (e) {
      print(e.toString());
    }
  }

//TODO: work on the api version
  Future<void> accountRecoveryEmail(BuildContext context, String email) async {
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final response = await http.post(
          Uri.parse('$url/api/user/recovery-email'),
          body: jsonEncode({'email': email}),
          headers: header);
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final tokenid = data['tokenid'];
        _pref.setString('email', email);
        _pref.setString('tokenid', tokenid);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const VerifyDetailsPage()));
      } else {
        errorToast(data['message']);
      }
    } on SocketException catch (e) {
      errorToast('No Internet connection');
    } catch (e) {
      print(e.toString());
    }
  }

  //TODO: work on this
  Future<void> accountRecoveryCode(BuildContext context, String otp) async {
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final tokenid = _pref.getString('tokenid');
      final response = await http.post(
          Uri.parse('$url/api/user/recovery-email'),
          body: jsonEncode({'otp': otp, 'token': tokenid}),
          headers: header);
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final tokenid = data['tokenid'];
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const NewPasswordPage()));
      } else {
        errorToast(data['message']);
      }
    } on SocketException catch (e) {
      errorToast('No Internet connection');
    } catch (e) {
      print(e.toString());
    }
  }

//TODO: work on this
  Future<void> accountRecoveryNewPassword(
      BuildContext context, String password) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    final email = _pref.getString('email');
    try {
      final response = await http.post(Uri.parse('$url/api/user/new-password'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: header);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _pref.setString('token', data['token']);
        successToast(data['message']);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const NavPage()),
        );
      } else {
        errorToast(data['message']);
      }
    } on SocketException catch (e) {
      errorToast('No Internet connection');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> verifyOTP(
      BuildContext context, PageController pageController, String otp) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final tokenid = pref.getString('tokenid');
      final email = pref.getString('email');
      var body = jsonEncode({'otp': otp, 'tokenid': tokenid, 'email': email});
      final response = await http.post(Uri.parse('$url/api/user/verify-otp'),
          body: jsonDecode(body), headers: header);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linearToEaseOut);
      } else {
        errorToast(data['message']);
      }
    } on SocketException catch (e) {
      errorToast('No Internet connection');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> resendOTP(BuildContext context) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final tokenid = pref.getString('tokenid');
      final email = pref.getString('email');

      var body = jsonEncode({'tokenid': tokenid, 'email': email});
      final response = await http.post(Uri.parse('$url/api/user/resend-otp'),
          body: jsonDecode(body), headers: header);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('OTP has been sent')));
      } else {
        var data = jsonDecode(response.body);
        errorToast(data['message']);
      }
    } on SocketException catch (e) {
      errorToast('No Internet connection');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createUser(BuildContext context, String password,
      PageController pageController) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      // {firstname,lastname,username,email,phone,password,referralcode}

      final email = pref.getString('email');

      var body = jsonEncode({
        'firstname': pref.getString('firstname'),
        'lastname': pref.getString('lastname'),
        'username':
            '${pref.getString('lastname')}_${pref.getString('phonenumber')}',
        'phone': pref.getString('phonenumber'),
        'password': password,
        'email': email,
        'referralcode': pref.getString('phonenumber')
      });
      final response = await http.post(Uri.parse('$url/api/user/register'),
          body: jsonDecode(body), headers: header);
      print(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        pref.setString('token', data['token']);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
          backgroundColor: Colors.green,
        ));

        pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linearToEaseOut);
      } else {
        errorToast(data['message']);
      }
    } on SocketException catch (e) {
      errorToast('No Internet connection');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> setPin(BuildContext context, String pin) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('pin', pin);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const NavPage()));
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      // Prepare the request body
      var body = jsonEncode({
        'password': password,
        'email': email,
      });

      // Send HTTP POST request
      final response = await http.post(
        Uri.parse('$url/api/user/login'),
        body: body, // Use the JSON string directly
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print(response.body.toString());

      // Decode response
      var data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        pref.setString('token', data['token']);
        successToast(data['message']);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const NavPage()),
        );
      } else {
        errorToast(data['message']);
      }
    } on SocketException {
      errorToast('No Internet');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> generateAddress(String coin, String chain,
      PageController pageController, WidgetRef ref) async {
    final CoinAddress coinAddress;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');

    print('$coin $chain');
    try {
      final Uri _url =
          Uri.parse('$url/api/crypto/deposit-coin/$coin/$chain/$token');
      print(_url);
      final response = await http.get(_url);
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        coinAddress = CoinAddress.fromJson(data['data']['result']);
        ref.read(coinAddressProvider.notifier).state = coinAddress;
        pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linearToEaseOut);
        return;
      } else {
        errorToast(data['message']);
      }
    } on SocketException catch (e) {
      errorToast('No Internet connection');
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> verifyBankName(WidgetRef ref, String accountNumber) async {
  //   final String url = dotenv.get('URL', fallback: '');
  //   if (url.isEmpty) {
  //     throw Exception("URL not found or empty in environment variables");
  //   }
  //  // final selectedBankList = ref.watch(selectbanklist);

  //   String name;
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //           '$url/api/banks/verifyAccount/$accountNumber/
  //           ${selectedBankList!.code}'),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       print(response.body);

  //       if (data['data'] != null) {
  //         name = data['data'];
  //         ref.read(usernameOnBankProvider.notifier).state = name;
  //       }
  //     } else {
  //       print('Error: ${response.statusCode}, ${response.body}');
  //       throw Exception('Failed to fetch coins: ${response.body}');
  //     }
  //   } on SocketException {
  //     print('No Internet connection');
  //     errorToast('No Internet connection');
  //   } catch (e) {
  //     print('Error: $e');
  //     throw Exception('An unexpected error occurred: $e');
  //   }
  // }


  Future<void> saveBankDetails(BuildContext context, String bankcode,
      String bankname, String accountnumber, String accountname) async {
    // const {bank_code,bankname,account_number,account_name,userid}= req.body
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    try {
      var body = {
        "bank_code": bankcode,
        "bankname": bankname,
        "account_number": accountnumber,
        "account_name": accountname,
        "token": token
      };
      print(body);
      final respones = await http.post(Uri.parse('$url/api/banks/add-bank'),
          headers: {
            "Content-Type": "application/json", // Ensure correct content type
          },
          body: jsonEncode(body));
      print(respones.body.toString());
      var data = jsonDecode(respones.body);
      if (respones.statusCode == 200) {
        successToast(data['message']);
      } else {
        errorToast(data['message']);
      }
    } on SocketException catch (e) {
      errorToast('No Internet connection');
    } catch (e) {
      errorToast('No Internet connection');
    }
  }

  Future<void> sellCoin(
    CoinBalance coin,
    double amountinNaira,
    String amount,
  ) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString('token');

    if (token == null || token.isEmpty) {
      errorToast('Token not found or empty');
      return;
    }

    try {
      var body = {
        "coinName": coin.coin,
        "amount": amount,
        "token": token,
        "amountinNaira": amountinNaira
      };

      print(body);

      final response = await http.post(
        Uri.parse('$url/api/crypto/sell-coin'),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json", // Ensure correct content type
        },
      );

      final data = jsonDecode(response.body);
      print(response.body.toString());

      if (response.statusCode == 200 && data['status'] == true) {
        successToast(data['message']);
      } else {
        errorToast(data['message'] ?? 'Failed to sell coin');
      }
    } on SocketException {
      errorToast('No Internet connection');
    } catch (e) {
      print(e.toString());
      errorToast('Something went wrong: ${e.toString()}');
    }
  }

  Future<void> sendMoney(String code, double amount, String accountnumber,
      BuildContext context) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('token');

      if (token == null || token.isEmpty) {
        errorToast('Token not found or empty');
        return;
      }

      // const {bankcode,accountnumber,amount,token}= req.body;
      var body = {
        "bankcode": code,
        "accountnumber": accountnumber,
        "amount": amount.toInt(),
        "token": token
      };
      print(body);

      // const {bankcode,accountnumber,amount,token}= req.body;
      final response = await http.post(
        Uri.parse('$url/api/banks/user-transfer'),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json", // Ensure correct content type
        },
      );
      print(response.body);

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSuccessDialog(context, () {
          // Navigat
        });
        successToast(data['message']);
      } else {
        errorToast(data['message']);
      }
    } on SocketException {
      errorToast('No Internet connection');
    } catch (e) {
      print(e.toString());
      errorToast('Something went wrong: ${e.toString()}');
    }
  }





}
