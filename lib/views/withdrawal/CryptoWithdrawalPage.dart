import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nokuex/models/myCoinModel.dart';
import 'package:nokuex/server/ServerCalls.dart';
import 'package:nokuex/views/utils/myToast.dart';
import 'package:nokuex/views/withdrawal/WithdrawalMainPage.dart';

import '../utils/passcodeInput.dart';

final selectedCryptoWithdrawalProvider =
    StateProvider<CoinBalance?>((ref) => null);

class Cryptowithdrawalpage extends ConsumerStatefulWidget {
  const Cryptowithdrawalpage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CryptowithdrawalpageState();
}

class _CryptowithdrawalpageState extends ConsumerState<Cryptowithdrawalpage> {
  final PageController pageController = PageController();
  final amountInputController = TextEditingController();
  final _selectedNetwork = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    // ref.watch(pageIndexProvider.notifier).state = 0;
    amountInputController.dispose();
    _selectedNetwork.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final index = ref.watch(pageIndexProvider);
    return Consumer(
      builder: (context, ref, child) {
        ref.read(pageIndexProvider.notifier).state = index;
        return PageView(
          controller: pageController,
          onPageChanged: (value) =>
              ref.read(pageIndexProvider.notifier).state = value,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _pageOne(context, pageController),
            _pageTwo(context, pageController),
            _pageThree(context, pageController),
          ],
        );
      },
    );
  }

  Widget _pageThree(BuildContext context, PageController pageController) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        _moneyBoxThree(context),
        SizedBox(
          height: size.height * .02,
        ),
        _pageThreesummary(
          context,
        ),
      ],
    );
  }

  Widget _pageThreesummary(BuildContext context) {
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
        _summaryCard('Wallet Address', 'shdvhsdjkjsjkdjkskjbd'),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('Wallet Name', 'Obetta ikenna'),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('Network', 'TRC'),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('Amount to recieve', '2,000USDT'),
        SizedBox(
          height: size.height * .035,
        ),
        Center(
          child: GestureDetector(
            onTap: () => showPassCodeInput(context, () {}),
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

  Widget _summaryCard(String title, String des) {
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

  Widget _moneyBoxThree(BuildContext context) {
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
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(
            'Amount to transfer',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: size.height * 0.016),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Text(
            '$formattedAmount USDT',
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

  Widget _pageTwo(BuildContext context, PageController pageController) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        _moneyBoxTwo(context),
        SizedBox(
          height: size.height * .02,
        ),
        _pageTwoInput(context, _selectedNetwork),
      ],
    );
  }

  Widget _pageTwoInput(
      BuildContext context, TextEditingController? controller) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Network',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: size.height * 0.016),
          ),
        ),
        SizedBox(
          height: size.height * .005,
        ),
        TextFormField(
          controller: controller,
          readOnly: true,
          keyboardType: TextInputType.number,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.03),
          decoration: InputDecoration(
              hintText: 'Select Network',
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: size.height * 0.016),
              suffix: GestureDetector(
                onTap: () {},
                child: Icon(Icons.arrow_drop_down, color: Colors.white),
              )),
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Network',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: size.height * 0.016),
          ),
        ),
        SizedBox(
          height: size.height * .005,
        ),
        TextFormField(
          controller: controller,
          readOnly: false,
          keyboardType: TextInputType.number,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.03),
          decoration: InputDecoration(
            hintText: 'Receipient Wallet Address',
            hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: size.height * 0.016),
          ),
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linearToEaseOut);
              return;
            },
            child: Container(
              height: size.height * .07,
              width: size.width * .62,
              decoration: BoxDecoration(
                  color: const Color(0xffFF9B01),
                  borderRadius: BorderRadius.circular(size.height * .025)),
              child: Center(
                child: Text(
                  'Continue',
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

  Widget _moneyBoxTwo(BuildContext context) {
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
      height: size.height * .2,
      width: size.width * .9,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
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
          SizedBox(
            height: size.height * .015,
          ),
          Text(
            formattedrate,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: size.height * 0.016),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedAmount,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: size.height * 0.05),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "USDT",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: size.height * 0.016),
                ),
              ),
            ],
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

  Widget _pageOne(BuildContext context, PageController pageController) {
    final size = MediaQuery.of(context).size;

    final userCoins = ref.watch(usersCoinProvider);

    return Column(
      children: [
        _moneyBox(context, userCoins),
        SizedBox(
          height: size.height * .02,
        ),
        _pageOneInput(context, amountInputController),
        SizedBox(
          height: size.height * .035,
        ),
        GestureDetector(
          onTap: () {
            if (ref.read(selectedCryptoWithdrawalProvider.notifier).state ==
                null) {
              return errorToast('Please select coin');
            }
            pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linearToEaseOut);
            return;
          },
          child: Container(
            height: size.height * .07,
            width: size.width * .62,
            decoration: BoxDecoration(
                color: const Color(0xffFF9B01),
                borderRadius: BorderRadius.circular(size.height * .025)),
            child: Center(
              child: Text(
                'Continue',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: size.height * 0.016),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _pageOneInput(
      BuildContext context, TextEditingController? controller) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Enter Amount',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: size.height * 0.016),
          ),
        ),
        SizedBox(
          height: size.height * .01,
        ),
        TextFormField(
          controller: controller,
          readOnly: true,
          keyboardType: TextInputType.number,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.03),
          decoration: InputDecoration(
              suffix: GestureDetector(
            onTap: () {},
            child: Text(
              'MAX',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffFF9B01),
                  fontSize: size.height * 0.016),
            ),
          )),
        )
      ],
    );
  }

  Widget _moneyBox(BuildContext context, List<CoinBalance> coins) {
    final size = MediaQuery.of(context).size;
    final selectedCoin = ref.watch(selectedCryptoWithdrawalProvider);
    final balance = selectedCoin != null
        ? selectedCoin.walletBalance
        : coins.isNotEmpty
            ? coins[0].walletBalance
            : null;

    return coins.isEmpty
        ? const Center(
            child: Text(
              'Please Deposit',
              style: TextStyle(color: Colors.white),
            ),
          )
        : Container(
            height: size.height * .2,
            width: size.width * .9,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Wallet Balance',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: size.height * 0.016),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3).copyWith(left: 8),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0)
                                    .copyWith(right: 5),
                                child: SizedBox(
                                    height: size.height * .02,
                                    width: size.width * .04,
                                    child: Placeholder()),
                              ),
                              Text(
                                selectedCoin != null
                                    ? selectedCoin!.coin ?? ''
                                    : coins[0].coin ?? '',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: size.height * 0.016),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      balance!,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: size.height * 0.05),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selectedCoin != null
                            ? selectedCoin!.marketRate ?? ''
                            : coins[0].marketRate ?? '',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: size.height * 0.016),
                      ),
                    ),
                  ],
                ),
                Text(
                  selectedCoin != null
                      ? selectedCoin!.nairaBalance ?? ''
                      : coins[0].nairaBalance ?? '',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: size.height * 0.016),
                ),
              ],
            ),
          );
  }
}
