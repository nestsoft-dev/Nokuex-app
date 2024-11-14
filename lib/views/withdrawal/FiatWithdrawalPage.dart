import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nokuex/views/utils/passcodeInput.dart';
import 'package:nokuex/views/withdrawal/WithdrawalMainPage.dart';
import 'package:nokuex/views/withdrawal/receiptPage.dart';

class Fiatwithdrawalpage extends ConsumerStatefulWidget {
  const Fiatwithdrawalpage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FiatwithdrawalpageState();
}

class _FiatwithdrawalpageState extends ConsumerState<Fiatwithdrawalpage> {
  final PageController pageController = PageController();
  final amountInputController = TextEditingController();
  final _selectedNetwork = TextEditingController();

  final bankController = TextEditingController();
  final bankNumber = TextEditingController();

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
            _pageThree(context)
            // _pageThree(context, pageController),
          ],
        );
      },
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

  Widget _pageThree(BuildContext context) {
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
        _summaryCard('Account Name', 'Obetta ikenna'),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('Bank Name', 'GTBank'),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('Account Number', '****53774'),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('Amount to Transfer', '\$1,556,377.24'),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('Transaction Charges', '\$160.00'),
        SizedBox(
          height: size.height * .015,
        ),
        _summaryCard('You will receive', '\$1,534.36'),
        SizedBox(
          height: size.height * .035,
        ),
        Center(
          child: GestureDetector(
            onTap: () => showPassCodeInput(
                context,
                () => showSuccessDialog(
                    context,
                    () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const ReceiptPage())))),
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

  Widget _pageTwo(BuildContext context, PageController pagecontroller) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        _moneyBoxTwo(context),
        SizedBox(
          height: size.height * .02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Account',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: size.height * 0.016),
            ),
            GestureDetector(
              onTap: () => showAddBank(context, bankController, bankNumber),
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: Color(0xffFF9B01),
                  ),
                  SizedBox(
                    width: size.width * .015,
                  ),
                  Text(
                    'New Account',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFF9B01),
                        fontSize: size.height * 0.016),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * .02,
        ),
        _bankList(context),

        GestureDetector(
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
        SizedBox(
          height: size.height * .02,
        ),

        // _pageTwoInput(context, _selectedNetwork),
      ],
    );
  }

  Widget _bankList(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int? selectedBank;
    return Consumer(
      builder: (context, ref, child) {
        return Expanded(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 3,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        if (selectedBank == index) {
                          selectedBank = null;
                        } else {
                          selectedBank = index;
                        }
                        setState(() {});
                        print(selectedBank);
                      },
                      child: Container(
                        height: size.height * .08,
                        padding: const EdgeInsets.all(10),
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/btc.svg'),
                                    SizedBox(
                                      width: size.width * .02,
                                    ),
                                    Text(
                                      'GTBank',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: size.height * 0.016),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '******6374',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: size.height * 0.016),
                                    ),
                                    Text(
                                      'Obetta ikenna',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: size.height * 0.016),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            selectedBank == index
                                ? const Positioned(
                                    child: Icon(Icons.check_box_sharp,
                                        color: Color(0xffFF9B01)),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  );
                }));
      },
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
      height: size.height * .17,
      width: size.width * .9,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(
            'Amount to Transfer',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: size.height * 0.016),
          ),
          SizedBox(
            height: size.height * .015,
          ),
          Text(formattedrate,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: size.height * 0.05)),
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
    return Column(
      children: [
        _moneyBox(context),
        SizedBox(
          height: size.height * .02,
        ),
        _pageOneInput(context, amountInputController),
        SizedBox(
          height: size.height * .035,
        ),
        GestureDetector(
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

  Widget _moneyBox(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final usdt = '1534.36';
    String formattedAmount = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '\$',
      decimalDigits: 2,
    ).format(double.tryParse(usdt));

    final rate = '1534.00';
    String formattedrate = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '\$',
      decimalDigits: 2,
    ).format(double.tryParse(usdt));
    return Container(
      height: size.height * .18,
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
                          padding: const EdgeInsets.all(2.0).copyWith(right: 5),
                          child: SizedBox(
                              height: size.height * .02,
                              width: size.width * .04,
                              child: const Placeholder()),
                        ),
                        Text(
                          'NGN',
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
          Text(
            formattedAmount,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: size.height * 0.05),
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
}
