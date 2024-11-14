import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:nokuex/views/CryptoDeposit/CryptoDepositMainPage.dart';
import 'package:nokuex/views/SwapCrypto/swapCryptoPage.dart';
import 'package:nokuex/views/home/morePage.dart';
import 'package:nokuex/views/notification/NotificationPage.dart';
import 'package:nokuex/views/withdrawal/WithdrawalMainPage.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: size.height * .02,
              ),
              _top(context),
              SizedBox(
                height: size.height * .02,
              ),
              _moneyBox(context),
              SizedBox(
                height: size.height * .02,
              ),
              _btcCard(context),
              SizedBox(
                height: size.height * .02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Services',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: size.height * 0.02),
                ),
              ),

              SizedBox(
                height: size.height * .02,
              ),
              //service card
              _serviceCard(context),
              SizedBox(
                height: size.height * .04,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Assets',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: size.height * 0.02),
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),

              //assets cards
              _assetsCard(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _assetsCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: size.height * .11,
              width: size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff252A30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          //icon
                          SvgPicture.asset(
                            'assets/btc.svg',
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),

                          //name
                          Text(
                            'Bitcoin',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: size.height * 0.02),
                          ),
                        ],
                      ),

                      //price
                      Text(
                        '\$4,500',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: size.height * 0.02),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //chart, percent, bal
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: size.height * .05,
                            width: size.width * .155,
                            child: Placeholder(),
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Text(
                            '3.5%',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                                fontSize: size.height * 0.02),
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Text(
                            '\$3.5',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: size.height * 0.02),
                          ),
                        ],
                      ),

                      //coin Balance
                      Text(
                        '0.0000000045 BTC',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: size.height * 0.02),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _serviceCard(BuildContext context) {
    List<Map<String, String>> _cardItem = [
      {'title': 'Receive', 'image': 'assets/receive.svg'},
      {'title': 'Send', 'image': 'assets/send.svg'},
      {'title': 'Trade', 'image': 'assets/trade.svg'},
      {'title': 'More', 'image': 'assets/more.svg'}
    ];
    onTap(int index) {
      switch (index) {
        case 0:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CryptoDepostMainPage()));

          break;
        case 1:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => WithdrawalMainPage()));

          break;
        case 2:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SwapCryptoPage()));

          break;
        default:
      }
    }

    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .11,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _cardItem.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: EdgeInsets.only(right: size.width * 0.02),
                  child: GestureDetector(
                    onTap: () {
                      if (index == 3) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const MorePage()));
                        return;
                      } else {
                        onTap(index);
                        return;
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          height: size.height * .07,
                          width: size.width * .2,
                          decoration: BoxDecoration(
                              color: index == 0
                                  ? Colors.green
                                  : index == 1
                                      ? Color(0xffFF9B01)
                                      : index == 2
                                          ? Color(0xffEFC1F7)
                                          : Color(0xff44457B),
                              shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(
                              _cardItem[index]['image']!,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _cardItem[index]['title']!,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: size.height * 0.02),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  Widget _btcCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * .065,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/btc.svg',
                color: Color(0xffFF9B01),
              ),
              SizedBox(
                width: size.width * .035,
              ),
              Text(
                'BTC',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: size.height * 0.02),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '0.00000045',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff39A798),
                    fontSize: size.height * 0.02),
              ),
              //chart
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width * .1,
                  child: Placeholder(),
                ),
              ),
              Text(
                '3.8%',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff39A798),
                    fontSize: size.height * 0.02),
              ),
            ],
          )
        ],
      ),
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

    final List<Map<String, String>> _cardItem = [
      {'name': 'Withdraw', 'image': 'assets/money-send.svg'},
      {'name': 'Deposit', 'image': 'assets/money-recive.svg'},
      {'name': 'Swap', 'image': 'assets/bitcoin-convert.svg'},
    ];

    onTap(int index) {
      switch (index) {
        case 0:
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const WithdrawalMainPage()));

          break;
        case 1:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CryptoDepostMainPage()));

          break;
        case 2:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SwapCryptoPage()));

          break;
        default:
      }
    }

    return Container(
      height: size.height * .22,
      width: size.width * .9,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Wallet',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: size.height * 0.016),
              ),
              Container(
                padding: const EdgeInsets.all(3).copyWith(left: 8),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Text(
                      'USD',
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
          SizedBox(
            height: size.height * .01,
          ),
          SizedBox(
            width: size.width,
            height: size.height * .045,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => onTap(index),
                      child: Container(
                        width: size.width * .25,
                        height: size.height * .005,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: index == 0 ? Colors.black : Colors.white12,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                _cardItem[index]['image']!,
                              ),
                              Text(
                                ' ${_cardItem[index]['name']!}',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: size.height * 0.016),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _top(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: size.height * .08,
          width: size.width * .18,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        ),
        Row(
          children: [
            const Icon(
              Iconsax.setting,
              color: Colors.white,
            ),
            SizedBox(
              width: size.width * .08,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NotificationPage())),
              child: Container(
                height: size.height * .075,
                width: size.width * .14,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 23, 25, 28),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Iconsax.notification,
                  color: Colors.white,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
