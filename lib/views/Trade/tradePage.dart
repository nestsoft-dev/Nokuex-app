import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/views/Trade/buyCrypto.dart';
import 'package:nokuex/views/Trade/sellTrade.dart';
import 'package:nokuex/constants/appconstant_data.dart';

final tradePairIndexProvider = StateProvider((ref) => 0);

final selectedDayProvider = StateProvider((ref) => 0);

class TradeMainPage extends ConsumerWidget {
  const TradeMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: size.height * .08,
              ),
              _myAppBar(context),
              SizedBox(
                height: size.height * .023,
              ),
              _listNames(context),
              SizedBox(
                height: size.height * .023,
              ),
              _coinTabList(context),
              SizedBox(
                height: size.height * .023,
              ),
              _coinBox(context),
              SizedBox(
                height: size.height * .023,
              ),
              _days(context),
              SizedBox(
                height: size.height * .023,
              ),
              _chart(context),
              SizedBox(
                height: size.height * .023,
              ),
              _buyorSell(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buyorSell(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => BuycryptoPage())),
          child: Container(
            height: size.height * .065,
            width: size.width * .45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: myorange),
            child: Center(
              child: Text(
                'Buy',
                style: TextStyle(
                    color: Colors.white, fontSize: size.height * 0.016),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SellTrade())),
          child: Container(
            height: size.height * .065,
            width: size.width * .45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: myorange.withOpacity(0.2)),
            child: Center(
              child: Text(
                'Sell',
                style: TextStyle(
                    color: Colors.white, fontSize: size.height * 0.016),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _chart(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * .3,
      child: Placeholder(),
    );
  }

  Widget _days(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> _time = [
      'Today',
      '1 w',
      '1 m',
      '3 m',
      '1 y',
    ];
    return SizedBox(
      height: size.height * .04,
      width: size.width,
      child: Consumer(
        builder: (context, ref, child) {
          final selectedIndex = ref.watch(selectedDayProvider);
          return ListView.builder(
              itemCount: _time.length,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      if (selectedIndex == index) {
                        return;
                      } else {
                        ref.read(selectedDayProvider.notifier).state = index;
                      }
                    },
                    child: Container(
                      height: size.height * .1,
                      width: size.width * .15,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: selectedIndex == index
                              ? const Color(0xff252A30)
                              : Colors.black),
                      child: Center(
                        child: Text(
                          _time[index],
                          style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.grey,
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ));
        },
      ),
    );
  }

  Widget _coinBox(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      //height: size.height * .11,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              colors: [Color(0xff5E90D5), Color(0xff177DFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //icon,name, drop menue
              Row(
                children: [
                  SvgPicture.asset('assets/btc.svg'),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  Text(
                    'Ethereuem',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: size.height * 0.018),
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  )
                ],
              ),

              //value
              Text(
                '\$12,567.98',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: size.height * 0.018),
              ),
            ],
          ),
          SizedBox(
            height: size.height * .015,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //short name
              Text(
                'Eth',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: size.height * 0.018),
              ),
              Row(
                children: [
                  Text(
                    '+4.5%',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: size.height * 0.018),
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  SizedBox(
                    height: size.height * .05,
                    width: size.width * .15,
                    child: Placeholder(),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _coinTabList(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .095,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Container(
                // height: size.height * .09,
                width: size.width * .55,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xff252A30),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //icon, name
                        Row(
                          children: [
                            SvgPicture.asset('assets/btc.svg'),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(
                              'BNB',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: size.height * 0.016),
                            )
                          ],
                        ),

                        //chart
                        SizedBox(
                          height: size.height * .02,
                          width: size.width * .15,
                          child: Placeholder(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * .005,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '+1.37',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                              fontSize: size.height * 0.016),
                        ),
                        Text(
                          '0.4956',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: size.height * 0.016),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _listNames(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> _names = [
      'Top 5',
      'Top Losers',
      'Top Gainers',
      'Popular Pairs'
    ];

    return SizedBox(
      width: size.width,
      height: size.height * .04,
      child: ListView.builder(
        itemCount: _names.length,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Consumer(
            builder: (context, ref, child) {
              final selectedIndex = ref.watch(tradePairIndexProvider);
              return GestureDetector(
                onTap: () {
                  if (selectedIndex == index) {
                    return;
                  } else {
                    ref.read(tradePairIndexProvider.notifier).state = index;
                  }
                },
                child: Text(
                  _names[index],
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color:
                          selectedIndex == index ? Colors.white : Colors.grey,
                      fontSize: size.height * 0.015),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _myAppBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Trade',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.025),
        ),
        Container(
          padding: const EdgeInsets.all(3).copyWith(left: 8, right: 9),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0).copyWith(right: 5),
                child: SvgPicture.asset(
                  height: size.height * .03,
                  'assets/d_history.svg',
                  color: Colors.white,
                ),
              ),
              Text(
                'Swap',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: size.height * 0.016),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget coinBox(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    //height: size.height * .11,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
            colors: [Color(0xff5E90D5), Color(0xff177DFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //icon,name, drop menue
            Row(
              children: [
                SvgPicture.asset('assets/btc.svg'),
                SizedBox(
                  width: size.width * .02,
                ),
                Text(
                  'Ethereuem',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: size.height * 0.018),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                )
              ],
            ),

            //value
            Text(
              '\$12,567.98',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: size.height * 0.018),
            ),
          ],
        ),
        SizedBox(
          height: size.height * .015,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //short name
            Text(
              'Eth',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: size.height * 0.018),
            ),
            Row(
              children: [
                Text(
                  '+4.5%',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: size.height * 0.018),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                SizedBox(
                  height: size.height * .05,
                  width: size.width * .15,
                  child: Placeholder(),
                )
              ],
            )
          ],
        )
      ],
    ),
  );
}
