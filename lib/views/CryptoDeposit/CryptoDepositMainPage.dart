import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/models/addressModel.dart';
import 'package:nokuex/models/supportedCoin.dart';
import 'package:nokuex/server/ServerCalls.dart';
import 'package:nokuex/views/Auth/widgets/textInput.dart';
import 'package:nokuex/views/utils/myToast.dart';
import 'package:nokuex/widgets/myButton.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

final CryptoDepostMainPageIndexProvider = StateProvider((ref) => 0);

final selectedCryptoProvider = StateProvider<CryptoCurrency?>((ref) => null);

final selectedNetworkchainProvider = StateProvider<Chains?>((ref) => null);

class CryptoDepostMainPage extends ConsumerWidget {
  CryptoDepostMainPage({super.key});

  final PageController pageController = PageController();
  final selectedCryptoController = TextEditingController();
  final coinNetworkController = TextEditingController();

  @override
  void dispose() {
    selectedCryptoController.dispose();
    coinNetworkController.dispose();

    //  super.dispose();
  }

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
                      _pageOne(context, ref),
                      _pageTwo(context, ref),
                      _pageThree(context, ref),
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

  Widget _pageThree(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final CoinAddress? address = ref.watch(coinAddressProvider);
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
              data: address != null
                  ? address.chain.addressDeposit
                  : 'Address not correct',
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
                address != null
                    ? address!.chain.addressDeposit
                    : 'Address not correct',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: size.height * 0.016),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Clipboard.setData(
                        ClipboardData(text: address!.chain.addressDeposit));
                  },
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
                  address != null ? address.coin! : '',
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
              address != null ? address.chain.chainType! : '',
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

  Widget _pageTwo(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final selectedCoin = ref.watch(selectedCryptoProvider);
    final selectedChain = ref.watch(selectedNetworkchainProvider);
    final loading = ref.watch(loadingProvider);
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
                selectedCoin == null ? '' : selectedCoin!.name!,
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
          isReadonly: true,
          type: TextInputType.text,
          suffix: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Container(
                        height: size.height * .5,
                        width: size.width,
                        padding: const EdgeInsets.all(10),
                        color: Colors.black,
                        child: ListView.builder(
                            itemCount: selectedCoin!.chains!.length ?? 0,
                            itemBuilder: (_, index) {
                              return ListTile(
                                onTap: () async {
                                  ref
                                      .read(
                                          selectedNetworkchainProvider.notifier)
                                      .state = selectedCoin!.chains![index];

                                  coinNetworkController.text =
                                      selectedCoin!.chains![index].chainType!;

                                  Navigator.of(context).pop();
                                },
                                leading: Text(
                                  selectedCoin!.chains![index].chainType!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }));
                  });
            },
            child: const Icon(Icons.arrow_drop_down, color: Colors.white),
          ),
        ),
        SizedBox(
          height: size.height * .035,
        ),
        Center(
          child: loading
              ? const CircularProgressIndicator.adaptive()
              : MyButton(
                  text: 'Get Address',
                  onTap: () async {
                    ref.read(loadingProvider.notifier).state = true;
                    await Servercalls().generateAddress(selectedCoin!.coin!,
                        selectedChain!.chain ?? '', pageController, ref);

                    ref.read(loadingProvider.notifier).state = false;
                  }),
        )
      ],
    );
  }

  Widget _pageOne(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final supportedCoinList = ref.watch(allCoinListProvider);
    final loading = ref.watch(loadingProvider);
    final selectedCoin = ref.watch(selectedCryptoProvider);

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
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Container(
                      height: size.height * .5,
                      width: size.width,
                      padding: const EdgeInsets.all(10),
                      color: Colors.black,
                      child: supportedCoinList.when(
                          data: (coin) {
                            return ListView.builder(
                                itemCount: coin.length,
                                itemBuilder: (_, index) {
                                  return ListTile(
                                    onTap: () {
                                      ref
                                          .read(selectedCryptoProvider.notifier)
                                          .state = coin[index];

                                      selectedCryptoController.text =
                                          coin[index].name!;
                                      Navigator.of(context).pop();
                                    },
                                    leading: Text(
                                      coin[index].coin!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                });
                          },
                          error: (error, trace) => const Center(
                                child: Text(
                                  'Network connection issue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                          loading: () => const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )),
                    );
                  });
            },
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
          child: loading
              ? const CircularProgressIndicator.adaptive()
              : MyButton(
                  text: 'Continue',
                  onTap: () async {
                    if (selectedCoin == null) {
                      errorToast('Please select a crypto');
                      return;
                    }
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
