import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/views/Auth/widgets/textInput.dart';
import 'package:nokuex/widgets/myButton.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

final CryptoDepostMainPageIndexProvider = StateProvider((ref) => 0);

class CryptoDepostMainPage extends ConsumerWidget {
  CryptoDepostMainPage({super.key});

  final PageController pageController = PageController();
  final selectedCryptoController = TextEditingController();
  final coinNetworkController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
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
                final index = ref.watch(CryptoDepostMainPageIndexProvider);
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    index == 0
                        ? 'Deposit'
                        : index == 1
                            ? 'Deposit Crypto'
                            : 'Confirm Transaction',
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
                final index = ref.watch(CryptoDepostMainPageIndexProvider);
                return Expanded(
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (value) => ref
                        .read(CryptoDepostMainPageIndexProvider.notifier)
                        .state = value,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _pageOne(context),
                      _pageTwo(context),
                      _pageThree(context),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _pageThree(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * .04,
          width: size.width * .9,
          decoration: BoxDecoration(
              color: const Color(0xff282C33),
              borderRadius: BorderRadius.circular(15)),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Container(
          height: size.height * .3,
          width: size.width * .7,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color(0xff282C33),
          ),
          child: Center(
            child: PrettyQrView.data(
              data: 'lorem ipsum dolor sit amet',
            ),
          ),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Wallet Address',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: size.height * 0.016),
          ),
        ),
        SizedBox(
          height: size.height * .015,
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                'vdyjsvjhdvjvjevsvlsvdvhsvdvikvdkkdvkdhjjljjnidh',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: size.height * 0.016),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.copy,
                    color: Color(0xffFF9B01),
                  )),
            )
          ],
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Coin',
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
          height: size.height * .02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Network',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: size.height * 0.016),
            ),
            Text(
              'Tron',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * 0.016),
            ),
          ],
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Center(
          child: MyButton(
            text: 'Done',
            onTap: () => Navigator.of(context).pop(),
            color: Colors.green,
          ),
        )
      ],
    );
  }

  Widget _pageTwo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: size.height * .045,
          width: size.width * .3,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/btc.svg',
                height: size.height * .045,
                width: size.width * .045,
              ),
              Text(
                'Tether',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: size.height * 0.02),
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height * .035,
        ),
        MyInput(
          title: 'Network',
          hint: 'Select Coin Network',
          controller: coinNetworkController,
          isPassword: false,
          type: TextInputType.text,
          suffix: GestureDetector(
            onTap: () {},
            child: const Icon(Icons.arrow_drop_down, color: Colors.white),
          ),
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Center(
          child: MyButton(
              text: 'Get Address',
              onTap: () {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linearToEaseOut);
                return;
              }),
        )
      ],
    );
  }

  Widget _pageOne(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        MyInput(
          title: 'Select Crypto',
          hint: 'Select Crypto',
          controller: selectedCryptoController,
          isPassword: false,
          type: TextInputType.text,
          isReadonly: true,
          suffix: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: size.height * .03,
        ),
        Center(
          child: MyButton(
              text: 'Continue',
              onTap: () {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linearToEaseOut);
                return;
              }),
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
                final index = ref.watch(CryptoDepostMainPageIndexProvider);
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
              ' of 3',
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
