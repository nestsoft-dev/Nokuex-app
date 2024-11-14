import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:nokuex/views/utils/passcodeInput.dart';
import 'package:nokuex/widgets/myButton.dart';

final swapcoinIndexProvider = StateProvider((ref) => 0);

class SwapCryptoPage extends ConsumerWidget {
  SwapCryptoPage({super.key});
  final PageController pageController = PageController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .07,
            ),
            _myAppBar(context),
            SizedBox(
              height: size.height * .02,
            ),
            Consumer(
              builder: (context, ref, child) {
                final index = ref.watch(swapcoinIndexProvider);
                return Text(
                  'Swap Crypto',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: size.height * 0.025),
                );
              },
            ),
            SizedBox(
              height: size.height * .035,
            ),
            Consumer(
              builder: (context, ref, child) {
                return Expanded(
                    child: PageView(
                  controller: pageController,
                  onPageChanged: (value) =>
                      ref.read(swapcoinIndexProvider.notifier).state = value,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _pageOne(context),
                    _pageTwo(context),
                    // _pageThree(context),
                  ],
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
    return Column(children: [
      _moneyBoxTwo(context),
      SizedBox(
        height: size.height * .02,
      ),
      Column(
        children: [
          //from
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'From',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: size.height * 0.016),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/btc.svg'),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  Text(
                    'Tether',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.height * 0.016),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * .013,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'To',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: size.height * 0.016),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/btc.svg'),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  Text(
                    'Bitcoin',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.height * 0.016),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * .013,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1 BTC',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: size.height * 0.016),
              ),
              Text(
                '0.000000537 BTC',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: size.height * 0.016),
              ),
            ],
          ),
          SizedBox(
            height: size.height * .013,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'You will recieve',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: size.height * 0.016),
              ),
              Text(
                '0.000000537 BTC',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: size.height * 0.016),
              ),
            ],
          ),
          SizedBox(
            height: size.height * .04,
          ),
          Center(
            child: MyButton(
                color: Colors.green,
                text: 'Confirm',
                onTap: () => showSuccessDialog(context, () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    })),
          )
        ],
      )
    ]);
  }

  Widget _moneyBoxTwo(BuildContext context) {
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
      // height: size.height * .16,
      width: size.width * .9,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Wallet Balance',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: size.height * 0.016),
          ),
          SizedBox(
            height: size.height * .008,
          ),
          Text(
            '0.00000045 BTC',
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _pageOneInput(context, 'From'),
      SizedBox(
        height: size.height * .025,
      ),
      const Center(
        child: Icon(
          Iconsax.convert,
          color: Color(0xffFF9B01),
        ),
      ),
      _pageOneInput(context, 'To'),
      SizedBox(
        height: size.height * .025,
      ),
      Container(
        width: size.width,
        height: size.height * .055,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // coin icon n name
            Row(
              children: [
                SvgPicture.asset('assets/btc.svg'),
                SizedBox(
                  width: size.width * .02,
                ),
                Text(
                  'BTC',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: size.height * 0.016),
                )
              ],
            ),

            //value when swaped
            Row(
              children: [
                Text(
                  '0.00000045',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      color: Colors.green,
                      fontSize: size.height * 0.016),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                const Icon(
                  Iconsax.recovery_convert,
                  color: Color(0xffFF9B01),
                )
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: size.height * .03,
      ),
      //enter swap amount
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter Amount to Swap',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: size.height * 0.016),
          ),
          SizedBox(
            height: size.height * .025,
          ),
          //selected coin icon, coin name, drow down
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/btc.svg'),
                      SizedBox(
                        width: size.width * .02,
                      ),
                      Text(
                        'USDT',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: size.height * 0.018),
                      ),
                      SizedBox(
                        width: size.width * .02,
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.white)
                    ],
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  Container(
                    width: size.width * 0.25,
                    color: Colors.grey,
                    height: 1,
                  )
                ],
              ),
              SizedBox(
                width: size.width * .03,
              ),
              Expanded(
                child: TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: '0.00'),
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: size.height * 0.03),
                ),
              )
            ],
          ),
        ],
      ),
      SizedBox(
        height: size.height * .04,
      ),
      Center(
        child: MyButton(
            text: 'Continue',
            onTap: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear);
              return;
            }),
      )
    ]);
  }

  Widget _pageOneInput(BuildContext context, String title) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: size.height * 0.016),
          ),
        ),
        SizedBox(
          height: size.height * .025,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/btc.svg'),
                    SizedBox(
                      width: size.width * .02,
                    ),
                    Text(
                      'Tether',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: size.height * 0.016),
                    )
                  ],
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.white)
              ],
            ),
            SizedBox(
              height: size.height * .025,
            ),
            Container(
              width: size.width,
              color: Colors.grey,
              height: 1,
            )
          ],
        )
      ],
    );
  }

  Widget _myAppBar(BuildContext context) {
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
                final index = ref.watch(swapcoinIndexProvider);
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
