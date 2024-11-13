import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

Future<void> showPassCodeInput(BuildContext context, VoidCallback success) {
  final size = MediaQuery.of(context).size;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 80,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            backgroundColor: Colors.black,
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: size.height * .35,
              width: size.width * .8,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your 4 Digit code',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: size.height * 0.023),
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  Center(
                    child: Pinput(
                      length: 4,
                      // controller: _pinCode,
                      obscureText: true,
                      defaultPinTheme: defaultPinTheme,
                      // focusedPinTheme: focusedPinTheme,
                      // submittedPinTheme: submittedPinTheme,
                      validator: (s) {
                        return s == '_pinCode.text.isEmpty'
                            ? 'Pin is empty'
                            : null;
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  Text(
                    'Your 4 digit PIN will be used to authorize all your\ntransactions on Treyd',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: size.height * 0.013),
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: size.height * .07,
                        width: size.width * .62,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.circular(size.height * .025)),
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: size.height * 0.016),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
}
