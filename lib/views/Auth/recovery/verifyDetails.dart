import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/views/Auth/recovery/newPasswordPage.dart';
import 'package:pinput/pinput.dart';

class VerifyDetailsPage extends ConsumerStatefulWidget {
  const VerifyDetailsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyDetailsPageState();
}

class _VerifyDetailsPageState extends ConsumerState<VerifyDetailsPage> {
  final _pinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            _topBox(context),
            _body(context),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
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
              '+2349138473122 ',
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
              'obettaikenna19@gmail.com',
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
          height: size.height * .038,
        ),
        Center(child: _buttonDesign(context)),
        SizedBox(
          height: size.height * .038,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Back to ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * .016),
            ),
            Text(
              'Login',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: size.height * .016),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buttonDesign(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const NewPasswordPage())),
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
