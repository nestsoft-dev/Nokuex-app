import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nokuex/views/Trade/tradePage.dart';
import 'package:nokuex/constants/appconstant_data.dart';
import 'package:nokuex/views/utils/passcodeInput.dart';
import 'package:nokuex/widgets/moneyBox.dart';
import 'package:nokuex/widgets/myButton.dart';

final sellCoinIndexProvider = StateProvider((ref) => 0);

class SellTrade extends ConsumerWidget {
  SellTrade({super.key});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .08,
            ),
            _topBar(context),
            SizedBox(
              height: size.height * .02,
            ),
            Consumer(
              builder: (context, ref, child) {
                final index = ref.watch(sellCoinIndexProvider);
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    index == 0 ? 'Sell' : 'Deposit Crypto',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.height * 0.03),
                  ),
                );
              },
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Consumer(
              builder: (context, ref, child) {
                return Expanded(
                    child: PageView(
                  controller: pageController,
                  onPageChanged: (value) =>
                      ref.read(sellCoinIndexProvider.notifier).state = value,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [_pageOne(context), _pageTwo(context)],
                ));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _pageTwo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        _moneyBoxsummary(context),
        SizedBox(
          height: size.height * .02,
        ),
        _pagesummary(context)
      ],
    );
  }

  Widget _pagesummary(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Coin',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: size.height * 0.016),
            ),
            Container(
              width: size.width * .2,
              padding: const EdgeInsets.all(3).copyWith(left: 8),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0).copyWith(right: 5),
                    child: SizedBox(
                        height: size.height * .02,
                        width: size.width * .04,
                        child: Placeholder()),
                  ),
                  Text(
                    'USDT',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: size.height * 0.016),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('Wallet Address', 'shdvhsdjkjsjkdjkskjbd', context),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('Type', 'Sell', context),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('Amount to recieve', '\$2,000', context),
        SizedBox(
          height: size.height * .035,
        ),
        Center(
          child: GestureDetector(
            onTap: () => showPassCodeInput(
                context,
                () => showSuccessDialog(context, () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    })),
            child: Container(
              height: size.height * .07,
              width: size.width * .62,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(size.height * .025)),
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
    );
  }

  Widget _summaryCard(String title, String des, BuildContext context) {
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

  Widget _moneyBoxsummary(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final usdt = '1534.36';
    String formattedAmount = NumberFormat().format(double.tryParse(usdt));

    final rate = '1534.00';
    String formattedrate = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '\$',
      decimalDigits: 2,
    ).format(double.tryParse(usdt));
    return Container(
      height: size.height * .16,
      width: size.width * .9,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xff282C33),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(
            'Amount to sell',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: size.height * 0.016),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Text(
            formattedrate,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: size.height * 0.045),
          ),
          Text(
            formattedrate,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: size.height * 0.016),
          ),
        ],
      ),
    );
  }

  Widget _pageOne(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        coinBox(context),
        SizedBox(
          height: size.height * .02,
        ),
        Text(
          'Your Sell',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.017),
        ),
        SizedBox(
          height: size.height * .015,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '0.040510',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * 0.025),
            ),
            Text(
              ' ETH',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: myorange,
                  fontSize: size.height * 0.017),
            ),
          ],
        ),
        SizedBox(
          height: size.height * .025,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'You Recieve',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: size.height * 0.017),
          ),
        ),
        SizedBox(
          height: size.height * .01,
        ),
        moneyBox(context, 'You Get'),
        SizedBox(
          height: size.height * .035,
        ),
        MyButton(
            text: 'Continue',
            onTap: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linearToEaseOut);
              return;
            })
      ],
    );
  }

  Widget _topBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final index = ref.watch(sellCoinIndexProvider);
                return Text(
                  (index + 1).toString(),
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: size.height * 0.02),
                );
              },
            ),
            Text(
              ' of 2',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: size.height * 0.02),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.red,
                fontSize: size.height * 0.02),
          ),
        ),
      ],
    );
  }
}
