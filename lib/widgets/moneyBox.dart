 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Widget moneyBox(BuildContext context,String? title) {
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
               title?? 'Wallet Balance',
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