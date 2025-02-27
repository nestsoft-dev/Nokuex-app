import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/server/ServerCalls.dart';
import 'package:nokuex/views/Auth/widgets/textInput.dart';
import 'package:nokuex/views/utils/myToast.dart';
import 'package:nokuex/views/withdrawal/FiatWithdrawalPage.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                      onTap: () {
                        Navigator.of(context).pop();
                        success();
                      },
                      child: Container(
                        height: size.height * .07,
                        width: size.width * .62,
                        decoration: BoxDecoration(
                            color: const Color(0xff026E02),
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

Future<void> showAddBank(
    BuildContext context,
    TextEditingController bankController,
    TextEditingController bankNumber,
    WidgetRef ref) {
  final size = MediaQuery.of(context).size;
  final bankList = ref.watch(banklistProvider);
  return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(15),
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title n close
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Account',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.height * 0.02),
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ))
                ],
              ),
              SizedBox(
                height: size.height * .03,
              ),
              Text(
                'Add a new account number to your details',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: size.height * 0.014),
              ),
              SizedBox(
                height: size.height * .03,
              ),
              MyInput(
                  title: 'Bank',
                  hint: 'Select Bank',
                  controller: bankController,
                  isPassword: false,
                  type: TextInputType.text,
                  isReadonly: true,
                  suffix: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Container(
                                height: size.height * .6,
                                width: size.width,
                                padding: EdgeInsets.all(10),
                                color: Colors.black,
                                child: bankList.when(
                                    data: (bank) {
                                      return ListView.builder(
                                          itemCount: bank.length,
                                          itemBuilder: (_, index) {
                                            return ListTile(
                                              onTap: () {
                                                ref
                                                    .read(bankProvider.notifier)
                                                    .state = bank[index];
                                                Navigator.of(context).pop();
                                              },
                                              leading: Text(
                                                bank[index].name.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                          });
                                    },
                                    error: (error, trace) => const Center(
                                          child: Text(
                                            'Error getting bank list',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                    loading: () => const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        )),
                              );
                            });
                      },
                      child: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ))),

              SizedBox(
                height: size.height * .03,
              ),
              MyInput(
                title: 'Account Number',
                hint: 'Enter your 10 digit account number',
                controller: bankNumber,
                isPassword: false,
                type: TextInputType.name,
              ),
              SizedBox(
                height: size.height * .03,
              ),
              Text(
                'Obetta Ikenna',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffFF9B01),
                    fontSize: size.height * 0.016),
              ),

              SizedBox(
                height: size.height * .015,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: size.height * .07,
                    width: size.width * .62,
                    decoration: BoxDecoration(
                        color: const Color(0xffFF9B01),
                        borderRadius:
                            BorderRadius.circular(size.height * .025)),
                    child: Center(
                      child: Text(
                        'Add Account',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: size.height * 0.016),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

Future<void> changePassword(BuildContext context,
    TextEditingController oldPassword, TextEditingController newPassword) {
  final size = MediaQuery.of(context).size;
  return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(15),
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title n close
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change Password',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.height * 0.02),
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ))
                ],
              ),
              SizedBox(
                height: size.height * .03,
              ),
              Text(
                'Update your account password',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: size.height * 0.014),
              ),
              SizedBox(
                height: size.height * .03,
              ),
              MyInput(
                  title: 'Old Password',
                  hint: 'Enter your old password',
                  controller: oldPassword,
                  isPassword: true,
                  type: TextInputType.text,
                  isReadonly: false,
                  suffix: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Show',
                        style: TextStyle(color: Colors.white),
                      ))),

              SizedBox(
                height: size.height * .03,
              ),
              MyInput(
                title: 'New Password',
                hint: 'Enter your new password',
                controller: newPassword,
                isPassword: true,
                type: TextInputType.name,
              ),
              SizedBox(
                height: size.height * .03,
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
                height: size.height * .015,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: size.height * .07,
                    width: size.width * .62,
                    decoration: BoxDecoration(
                        color: const Color(0xffFF9B01),
                        borderRadius:
                            BorderRadius.circular(size.height * .025)),
                    child: Center(
                      child: Text(
                        'Add Account',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: size.height * 0.016),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

Future<void> transactionPinChange(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 26, 26, 26).withOpacity(0.15),
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final _pinCode = TextEditingController();
  final _pinCodeNew = TextEditingController();
  String oldPin;

  savePin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final oldPin = pref.getString('pin') ?? '';
    if (oldPin != '' && oldPin == _pinCode.text && _pinCodeNew != _pinCode) {
      pref.setString('pin', _pinCodeNew.text);
      successToast('New pin set');
      Navigator.of(context).pop();
    } else if (oldPin != _pinCode.text) {
      errorToast('Old pin not correct');
      Navigator.of(context).pop();
    } else if (oldPin == _pinCodeNew.text) {
      errorToast('Old and New code can not be same');
      Navigator.of(context).pop();
    }
  }

  return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(15),
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title n close
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change Transaction PIN',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.height * 0.02),
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ))
                ],
              ),
              SizedBox(
                height: size.height * .03,
              ),
              Text(
                'Update your Transaction PIN',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: size.height * 0.014),
              ),
              SizedBox(
                height: size.height * .03,
              ),
              Text(
                'Enter old PIN',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: size.height * 0.014),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Center(
                child: Pinput(
                  length: 4,
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
                height: size.height * .03,
              ),
              Text(
                'Enter New PIN',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: size.height * 0.014),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Center(
                child: Pinput(
                  length: 4,
                  controller: _pinCodeNew,
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

              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () => savePin(),
                  child: Container(
                    height: size.height * .065,
                    width: size.width * .9,
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius:
                            BorderRadius.circular(size.height * .025)),
                    child: Center(
                      child: Text(
                        'Save pin',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: size.height * 0.016),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        );
      });
}

Future<void> transactionPinNew(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 26, 26, 26).withOpacity(0.15),
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final _pinCode = TextEditingController();
  final _pinCodeNew = TextEditingController();

  savePin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    if (_pinCodeNew.text != _pinCode.text) {
      errorToast('pin not same');
      Navigator.of(context).pop();
    } else if (_pinCodeNew.text == _pinCode.text) {
      pref.setString('pin', _pinCode.text);
      successToast('New pin set');
      Navigator.of(context).pop();
    }
  }

  return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(15),
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title n close
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Transaction PIN',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.height * 0.02),
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ))
                ],
              ),
              SizedBox(
                height: size.height * .03,
              ),
              Text(
                'Update your Transaction PIN',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: size.height * 0.014),
              ),
              SizedBox(
                height: size.height * .03,
              ),
              Text(
                'Enter New PIN',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: size.height * 0.014),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Center(
                child: Pinput(
                  length: 4,
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
                height: size.height * .03,
              ),
              Text(
                'Confirm New PIN',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: size.height * 0.014),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Center(
                child: Pinput(
                  length: 4,
                  controller: _pinCodeNew,
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
                height: size.height * .02,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => savePin(),
                  child: Container(
                    height: size.height * .07,
                    width: size.width * .85,
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius:
                            BorderRadius.circular(size.height * .015)),
                    child: Center(
                      child: Text(
                        'Save pin',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: size.height * 0.016),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

Future<void> showSuccessDialog(BuildContext context, VoidCallback success) {
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
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/check.svg',
                    height: size.height * .1,
                    width: size.width * .3,
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  Center(
                    child: Text(
                      'Successful',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: size.height * 0.015),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  Text(
                    'Your transaction was completed successfully.',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: size.height * 0.013),
                  ),
                  SizedBox(
                    height: size.height * .035,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: success,
                      child: Container(
                        height: size.height * .07,
                        width: size.width * .62,
                        decoration: BoxDecoration(
                            color: const Color(0xff026E02),
                            borderRadius:
                                BorderRadius.circular(size.height * .025)),
                        child: Center(
                          child: Text(
                            'Done',
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
