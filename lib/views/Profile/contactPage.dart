import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    } else {
      await launchUrl(_url);
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

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
                context, 'assets/facebook.svg', 'Continue with Facebook', () {
              _launchUrl(
                  'https://www.facebook.com/share/15rJm2e3au/?mibextid=wwXIfr');
            }),
            SizedBox(
              height: size.height * .03,
            ),
            _contactCard(context, 'assets/google.svg', 'Continue with Gmail',
                () {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'Info@nokuex.com',
                query: encodeQueryParameters(<String, String>{
                  'subject': 'Help request from Nokuex',
                }),
              );

              launchUrl(emailLaunchUri);
            }),
            SizedBox(
              height: size.height * .03,
            ),
            _contactCard(
                context, 'assets/whatsapp.svg', 'Continue with Whatsapp', () {
              _launchUrl('https://wa.link/5tz0s8');
            }),
          ],
        ),
      ),
    );
  }

  Widget _contactCard(BuildContext context, String imagePath, String title,
      VoidCallback onTap) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
