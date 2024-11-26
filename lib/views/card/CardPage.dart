import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:nokuex/views/CryptoDeposit/CryptoDepositMainPage.dart';
import 'package:nokuex/views/SwapCrypto/swapCryptoPage.dart';
import 'package:nokuex/views/withdrawal/WithdrawalMainPage.dart';

class CardPage extends ConsumerStatefulWidget {
  const CardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardPageState();
}

class _CardPageState extends ConsumerState<CardPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .08,
            ),
            Text(
              'My Wallet',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * 0.025),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            _moneyBox(context),
            SizedBox(
              height: size.height * .01,
            ),
            _minMenue(context),
            SizedBox(
              height: size.height * .01,
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _listContainer(context),
                    ),
                itemCount: 10,
                physics: const BouncingScrollPhysics())
          ],
        ),
      ),
    );
  }

  Widget _listContainer(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // height: size.height * .11,
      width: size.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //icon type, name, bal
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
                    'Obetta',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.height * 0.02),
                  ),
                ],
              ),
              Text(
                '\$4,500',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: size.height * 0.02),
              ),
            ],
          ),

          //coin name, coin value
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'BTC',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: size.height * 0.02),
                  ),
                  SizedBox(
                    width: size.width * .01,
                  ),
                  Text(
                    'BNB',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: size.height * 0.02),
                  ),
                ],
              ),
              Text(
                '0.00000045 BTC',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: size.height * 0.02),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _minMenue(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .11,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Transaction History',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: size.height * 0.016),
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
              Container(
                  height: size.height * .075,
                  width: size.width * .14,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 23, 25, 28),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Iconsax.filter,
                    color: Color(0xffFF9B01),
                  ))
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
                            color: index == 0
                                ? const Color(0xffFF9B01)
                                : Colors.white12,
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
}
