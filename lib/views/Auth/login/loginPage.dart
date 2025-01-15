import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/server/ServerCalls.dart';
import 'package:nokuex/views/Auth/recovery/enterDetailsPage.dart';
import 'package:nokuex/views/Auth/widgets/textInput.dart';
import 'package:nokuex/views/NavPage/NavPage.dart';

import '../registerPage.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPassword = true;
  bool loadinging = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              _topBox(context),
              _inputCard(
                  context,
                  _emailController,
                  _passwordController,
                  GestureDetector(
                    onTap: () => setState(() {
                      isPassword = !isPassword;
                    }),
                    child: Text(
                      isPassword ? 'Show' : 'Hide',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: size.height * .015),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputCard(
      BuildContext context,
      TextEditingController _numberController,
      TextEditingController _password,
      Widget suffix) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * .024),
        ),
        SizedBox(
          height: size.height * .015,
        ),
        Text(
          'Login to your account.',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        SizedBox(
          height: size.height * .05,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .01,
            ),
            MyInput(
                title: 'Email Address',
                hint: 'Your email address',
                controller: _emailController,
                isPassword: false,
                suffix: null,
                type: TextInputType.emailAddress),
          ],
        ),
        SizedBox(
          height: size.height * .025,
        ),
        MyInput(
          title: 'Password',
          hint: 'Enter Password',
          controller: _password,
          isPassword: isPassword,
          type: TextInputType.text,
          suffix: suffix,
        ),
        SizedBox(
          height: size.height * .015,
        ),
        Row(
          children: [
            Text(
              'Forget Password ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: size.height * .015),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const EnterDetailsPage()));
              },
              child: Text(
                'Recover',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: size.height * .015),
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Center(
          child: loadinging
              ? const CircularProgressIndicator.adaptive()
              : _buttonDesign(context),
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dont have an account? ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: size.height * .015),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              child: Text(
                'Sign Up',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: size.height * .015),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buttonDesign(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        setState(() {
          loadinging = true;
        });
        await Servercalls().login(
            context, _emailController.text, _passwordController.text.trim());
        setState(() {
          loadinging = false;
        });
      },
      child: Container(
        height: size.height * .07,
        width: size.width * .62,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(size.height * .025)),
        child: Center(
          child: Text(
            'Login',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: size.height * 0.016),
          ),
        ),
      ),
    );
  }

  Widget _topBox(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/nokuex.png',
            height: size.height * .05,
          ),
          Text(
            'Need Help?',
            maxLines: 1,
            style: TextStyle(color: Colors.grey, fontSize: size.height * 0.018),
          )
        ],
      ),
    );
  }
}
