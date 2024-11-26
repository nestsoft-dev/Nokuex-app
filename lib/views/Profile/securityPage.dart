import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/views/Profile/preferencesPage.dart';
import 'package:nokuex/views/utils/passcodeInput.dart';

class SecurityPage extends ConsumerWidget {
  SecurityPage({super.key});

  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.08,
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
              'Security',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: size.height * 0.032),
            ),
            SizedBox(
              height: size.height * .034,
            ),
            _cardItem(
                context,
                'assets/lock.svg',
                'Password',
                'Change account password',
                () => changePassword(context, oldPassword, newPassword)),
            SizedBox(
              height: size.height * .015,
            ),
            _cardItem(context, 'assets/pin.svg', 'Transaction PIN',
                'Change Transaction PIN', () => transactionPinChange(context)),
            SizedBox(
              height: size.height * .015,
            ),
            _cardItem(
                context,
                'assets/setting.svg',
                'Preferences',
                'Settings and configuration',
                () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const PreferencesPage()))),
            SizedBox(
              height: size.height * .015,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardItem(BuildContext context, String svg, String title, String des,
      VoidCallback ontap) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: size.width,
        height: size.height * .12,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0xff282C33),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: size.width * .16,
              height: size.height * .07,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white12.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: SvgPicture.asset(svg),
              ),
            ),
            SizedBox(
              width: size.width * .02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: size.height * 0.02),
                ),
                Text(
                  des,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 207, 204, 204),
                      fontSize: size.height * 0.016),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
