import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nokuex/views/Auth/login/loginPage.dart';
import 'package:nokuex/views/NavPage/NavPage.dart';
import 'package:nokuex/views/home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onBoardingPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String token = '';

  getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future.delayed(const Duration(seconds: 5), () {
      if (token.isNotEmpty || token != '') {
        bool hasExpired = JwtDecoder.isExpired(token);

        if (hasExpired == true) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginPage()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const NavPage()));
        }
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const OnBoardingPage()));
      }
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/nokuex.png',
          height: size.height * .12,
          width: size.width,
          // fit: BoxFit.fill,
        ),
      ),
    );
  }
}
