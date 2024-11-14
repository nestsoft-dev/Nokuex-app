import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nokuex/views/NavPage/NavPage.dart';

class ReceiptPage extends ConsumerWidget {
  const ReceiptPage({super.key});

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
              height: size.height * .08,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const NavPage())),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Text(
              'Receipt',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: size.height * 0.024),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            _moneyBox(context),
            SizedBox(
              height: size.height * .02,
            ),
            Column(
              children: [
                _summaryCard(context, 'Account Name', 'Obetta ikenna'),
                SizedBox(
                  height: size.height * .015,
                ),
                _summaryCard(context, 'Bank', 'GTBank'),
                SizedBox(
                  height: size.height * .015,
                ),
                _summaryCard(context, 'Type', 'Transfer'),
                SizedBox(
                  height: size.height * .015,
                ),
                _summaryCard(context, 'Account Number', '*****5263'),
                SizedBox(
                  height: size.height * .015,
                ),
                _summaryCard(context, 'Amount', '\$36,637.73'),
                SizedBox(
                  height: size.height * .015,
                ),
                _summaryCard(context, 'Fees', '\$160.00'),
                SizedBox(
                  height: size.height * .015,
                ),
                _summaryCard(context, 'Reference ID', '526363826Gts67'),
                SizedBox(
                  height: size.height * .015,
                ),
                _summaryCard(context, 'You will receive', '\$8,747.89'),
                SizedBox(
                  height: size.height * .03,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: size.height * .07,
                      width: size.width * .62,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                              BorderRadius.circular(size.height * .025)),
                      child: Center(
                        child: Text(
                          'Share',
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
            )
          ],
        ),
      ),
    );
  }

  Widget _moneyBox(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const rate = '1534.00';
    String formattedrate = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '\$',
      decimalDigits: 2,
    ).format(double.tryParse(rate));
    return Container(
      height: size.height * .2,
      width: size.width * .9,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xff282C33),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Image.asset(
            'assets/nokuex.png',
            height: size.height * .06,
          ),
          SizedBox(
            height: size.height * .005,
          ),
          Text(
            formattedrate,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: size.height * 0.045),
          ),
          Text(
            'Success',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: size.height * 0.02),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(BuildContext context, String title, String des) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: size.height * 0.016),
        ),
        Expanded(
          child: Text(
            des,
            maxLines: 2,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: size.height * 0.016),
          ),
        ),
      ],
    );
  }
}
