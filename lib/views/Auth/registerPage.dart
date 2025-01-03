// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/server/ServerCalls.dart';
import 'package:nokuex/views/NavPage/NavPage.dart';
import 'package:nokuex/views/utils/myToast.dart';
import 'package:pinput/pinput.dart';

import 'package:nokuex/views/Auth/widgets/textInput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/loginPage.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _registerController = PageController(initialPage: 0);

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              SizedBox(
                height: size.height * .15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/nokuex.png',
                      height: size.height * .05,
                    ),
                    Text(
                      _pageIndex == 0 ? 'Login' : 'Need Help?',
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white, fontSize: size.height * 0.018),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .85,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  controller: _registerController,
                  children: [
                    CreateFreeAccount(controller: _registerController),
                    VerifyEmailorPhone(controller: _registerController),
                    CreatePasswordPage(controller: _registerController),
                    const CreateAppCode()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateFreeAccount extends StatefulWidget {
  const CreateFreeAccount({super.key, required this.controller});
  final PageController controller;

  @override
  State<CreateFreeAccount> createState() => _CreateFreeAccountState();
}

class _CreateFreeAccountState extends State<CreateFreeAccount> {
  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  String? selectedCountryCode;

  bool loading = false;
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create your free account',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * .024),
        ),
        SizedBox(
          height: size.height * .015,
        ),
        Text(
          'To get started with Nokue, create your account',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        SizedBox(
          height: size.height * .05,
        ),
        MyInput(
            title: 'First Name',
            hint: 'Your first name',
            controller: _firstController,
            isPassword: false,
            suffix: null,
            type: TextInputType.text),
        SizedBox(
          height: size.height * .025,
        ),
        MyInput(
            title: 'Last Name',
            hint: 'Your last name',
            controller: _lastController,
            isPassword: false,
            suffix: null,
            type: TextInputType.text),
        SizedBox(
          height: size.height * .025,
        ),
        MyInput(
            title: 'Email Address',
            hint: 'Your email address',
            controller: _emailController,
            isPassword: false,
            suffix: null,
            type: TextInputType.emailAddress),
        SizedBox(
          height: size.height * .025,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Number',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: size.height * .016),
            ),
            SizedBox(
              height: size.height * .012,
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20).copyWith(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.withOpacity(0.15)),
                    child: Center(
                      child: Row(
                        children: [
                          CountryCodePicker(
                            textStyle: TextStyle(color: Colors.grey),
                            backgroundColor: Colors.black,
                            onChanged: (val) {
                              setState(() {
                                selectedCountryCode = val.dialCode;
                              });
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'IT',
                            favorite: ['+39', 'FR'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  controller: _numberController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  obscuringCharacter: '*',
                  cursorColor: Colors.white,
                  maxLength: 10,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      hintText: '+234',
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.grey.withOpacity(0.15),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.height * .015))),
                ))
              ],
            ),
            SizedBox(
              height: size.height * .025,
            ),
            Center(
                child: loading
                    ? const CircularProgressIndicator.adaptive()
                    : _buttonDesign(context, widget.controller)),
            SizedBox(
              height: size.height * .025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: size.height * 0.015),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                  },
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontSize: size.height * 0.015),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buttonDesign(BuildContext context, PageController _pageController) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        if (selectedCountryCode == null) {
          errorToast('Please select country code');
          return;
        }
        if (_emailController.text.isEmpty ||
            _numberController.text.isEmpty ||
            _firstController.text.isEmpty ||
            _lastController.text.isEmpty) {
          errorToast('Please fill the needed details');
          return;
        }

        setState(() {
          loading = true;
        });

        await Servercalls()
            .verifyEmailorPhone(
                _emailController.text,
                selectedCountryCode! + _numberController.text,
                _firstController.text,
                _lastController.text,
                context,
                _pageController)
            .whenComplete(() {
          setState(() {
            loading = false;
          });
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
            'Register',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: size.height * 0.016),
          ),
        ),
      ),
    );
  }
}

class VerifyEmailorPhone extends StatefulWidget {
  const VerifyEmailorPhone({super.key, required this.controller});
  final PageController controller;

  @override
  State<VerifyEmailorPhone> createState() => _VerifyEmailorPhoneState();
}

class _VerifyEmailorPhoneState extends State<VerifyEmailorPhone> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.15),
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final _pinCode = TextEditingController();

  String email = '';
  String phoneNumber = '';
  String firstname = '';
  bool loading = false;

  getDetails() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    email = _pref.getString('email') ?? '';
    phoneNumber = _pref.getString('phonenumber') ?? '';
    firstname = _pref.getString('firstname') ?? '';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your Phone Number',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * .024),
        ),
        SizedBox(
          height: size.height * .015,
        ),
        Text(
          'A 6 digit OTP code has been sent to',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        Row(
          children: [
            Text(
              '$phoneNumber ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: size.height * .016),
            ),
            Text(
              'and ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: size.height * .016),
            ),
            Text(
              '$email',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: size.height * .016),
            ),
          ],
        ),
        Text(
          'enter the code to continue.',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Text(
          'Enter OTP',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        SizedBox(
          height: size.height * .015,
        ),
        Center(
          child: Pinput(
            length: 6,
            controller: _pinCode,
            obscureText: true,
            defaultPinTheme: defaultPinTheme,
            // focusedPinTheme: focusedPinTheme,
            // submittedPinTheme: submittedPinTheme,
            validator: (s) {
              return s == _pinCode.text.isEmpty ? 'Pin is empty' : null;
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Resend code in ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * .016),
            ),
            Text(
              '60 secs',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: size.height * .016),
            ),
          ],
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Center(child: _buttonDesign(context, widget.controller))
      ],
    );
  }

  Widget _buttonDesign(BuildContext context, PageController _pageController) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        setState(() {
          loading = true;
        });
        await Servercalls().resendOTP(context);
        setState(() {
          loading = false;
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
            'Verify',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: size.height * 0.016),
          ),
        ),
      ),
    );
  }
}

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final PageController controller;

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final _password = TextEditingController();
  bool isPassword = true;
  bool isBiometric = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * .024),
        ),
        SizedBox(
          height: size.height * .015,
        ),
        Text(
          'You need to secure your account',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        MyInput(
          title: 'Password',
          hint: 'Create a strong password',
          controller: _password,
          isPassword: isPassword,
          type: TextInputType.text,
          suffix: GestureDetector(
            onTap: () => setState(() {
              isPassword = !isPassword;
            }),
            child: Text(
              isPassword ? 'Show' : 'Hide',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * .016),
            ),
          ),
        ),
        SizedBox(
          height: size.height * .015,
        ),
        Row(
          children: [
            Text(
              'Must be more than ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: size.height * .016),
            ),
            Text(
              '8 characters',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * .016),
            ),
            Text(
              'and contain at least ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: size.height * .016),
            ),
            Text(
              'one',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * .016),
            )
          ],
        ),
        Row(
          children: [
            Text(
              'capital letter, one number ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * .016),
            ),
            Text(
              'and ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: size.height * .016),
            ),
            Text(
              'one special character',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * .016),
            ),
          ],
        ),
        SizedBox(
          height: size.height * .04,
        ),
        Row(
          children: [
            Switch(
                value: isBiometric,
                onChanged: (val) {
                  setState(() {
                    isBiometric = !isBiometric;
                  });
                }),
            SizedBox(
              width: size.width * .024,
            ),
            Text(
              'Biometrics Authentications',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * .018),
            ),
          ],
        ),
        Text(
          'Allow authentication with device biometric',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Center(
            child: loading
                ? const CircularProgressIndicator.adaptive()
                : _buttonDesign(context, widget.controller))
      ],
    );
  }

  Widget _buttonDesign(BuildContext context, PageController _pageController) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        if (_password.text.isEmpty) {
          errorToast('Please provide password');
          return;
        }
        setState(() {
          loading = true;
        });
        await Servercalls()
            .createUser(context, _password.text, _pageController)
            .whenComplete(() {
          setState(() {
            loading = false;
          });
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
            'Start Trading',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: size.height * 0.016),
          ),
        ),
      ),
    );
  }
}

class CreateAppCode extends StatefulWidget {
  const CreateAppCode({super.key});

  @override
  State<CreateAppCode> createState() => _CreateAppCodeState();
}

class _CreateAppCodeState extends State<CreateAppCode> {
  final _pinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'One more thing, Obetta',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * .024),
        ),
        SizedBox(
          height: size.height * .012,
        ),
        Text(
          'One last thing, create a secure transaction PIN',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        SizedBox(
          height: size.height * .045,
        ),
        Text(
          'Create a 4 digit Transaction PIN',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        SizedBox(
          height: size.height * .025,
        ),
        Center(
          child: Pinput(
            length: 4,
            controller: _pinCode,
            obscureText: true,

            defaultPinTheme: PinTheme(
              width: 56,
              height: size.height * .08,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .015),
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.15),
                border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // focusedPinTheme: focusedPinTheme,
            // submittedPinTheme: submittedPinTheme,
            validator: (s) {
              return s == _pinCode.text.isEmpty ? 'Pin is empty' : null;
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Text(
          'Your 4 digit PIN will used to authorized all your\ntransactions on Treyd.',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        SizedBox(
          height: size.height * .05,
        ),
        Center(child: _buttonDesign(context))
      ],
    );
  }

  Widget _buttonDesign(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        if (_pinCode.text.isEmpty) {
          errorToast('Please set pin code');
          return;
        }
        await Servercalls().setPin(context, _pinCode.text);
      },
      child: Container(
        height: size.height * .07,
        width: size.width * .62,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(size.height * .025)),
        child: Center(
          child: Text(
            'All Done',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: size.height * 0.016),
          ),
        ),
      ),
    );
  }
}
