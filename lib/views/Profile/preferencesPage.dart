import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
              'Preferences',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: size.height * 0.032),
            ),
            SizedBox(
              height: size.height * .042,
            ),
            _cardTitle(
                context, 'Theme', 'Dark Mode', 'Use dark mode theme', null),
            SizedBox(
              height: size.height * .05,
            ),
            _cardTitle(context, 'Notifications', 'Email',
                'Get notifications via email', true),
            SizedBox(
              height: size.height * .05,
            ),
            _cardTitle(context, 'Security', '2FA',
                'Use 2FA for authorizing transactions', null),
          ],
        ),
      ),
    );
  }

  Widget _cardTitle(BuildContext context, String title, String subtitle,
      String des, bool? isSms) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: size.height * 0.018),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Row(
          children: [
            Switch(value: true, onChanged: (onChanged) {}),
            SizedBox(
              width: size.width * .03,
            ),
            Text(
              subtitle,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: size.height * 0.018),
            ),
          ],
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Text(
          des,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: size.height * 0.015),
        ),
        isSms == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Switch(value: true, onChanged: (onChanged) {}),
                      SizedBox(
                        width: size.width * .03,
                      ),
                      Text(
                        'SMS',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: size.height * 0.018),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Text(
                    'Get notification via SMS (Charges may apply)',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: size.height * 0.015),
                  ),
                ],
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
