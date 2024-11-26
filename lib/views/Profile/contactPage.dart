import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .08,
            ),
            GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.grey,
                )),
            SizedBox(
              height: size.height * .03,
            ),
            Text(
              'Help/Support',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: size.height * 0.032),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'You can contact us through any of\nthese medium',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: size.height * 0.018),
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            _contactCard(
                context, 'assets/facebook.svg', 'Continue with Facebook'),
            SizedBox(
              height: size.height * .03,
            ),
            _contactCard(context, 'assets/google.svg', 'Continue with Gmail'),
            SizedBox(
              height: size.height * .03,
            ),
            _contactCard(
                context, 'assets/whatsapp.svg', 'Continue with Whatsapp'),
          ],
        ),
      ),
    );
  }

  Widget _contactCard(BuildContext context, String imagePath, String title) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * .063,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 1)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath),
            SizedBox(
              width: size.width * .06,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: size.height * 0.018),
            )
          ],
        ),
      ),
    );
  }
}
