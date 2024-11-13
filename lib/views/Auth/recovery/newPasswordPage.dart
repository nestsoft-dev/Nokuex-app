import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/views/Auth/widgets/textInput.dart';

class NewPasswordPage extends ConsumerStatefulWidget {
  const NewPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewPasswordPageState();
}

class _NewPasswordPageState extends ConsumerState<NewPasswordPage> {
  final _password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topBox(context),
            _body(
                context,
                _password,
                confirmPassword,
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
            SizedBox(
              height: size.height * .035,
            ),
            Center(
              child: _buttonDesign(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonDesign(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: size.height * .07,
        width: size.width * .62,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(size.height * .025)),
        child: Center(
          child: Text(
            'Save',
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

  Widget _body(BuildContext context, TextEditingController _password,
      TextEditingController _confirmPassword, Widget suffix) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set a new Password',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * .024),
        ),
        SizedBox(
          height: size.height * .012,
        ),
        Text(
          'Set a new password for your account',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        SizedBox(
          height: size.height * .025,
        ),
        MyInput(
          title: 'New Password',
          hint: 'Create a strong password',
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
          height: size.height * .025,
        ),
        MyInput(
          title: 'Confirm Password',
          hint: 'Cronfirm password',
          controller: _confirmPassword,
          isPassword: isPassword,
          type: TextInputType.text,
          suffix: suffix,
        )
      ],
    );
  }
}
