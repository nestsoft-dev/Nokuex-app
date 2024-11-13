import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Map<String, String>> _cardItem = [
      {'title': 'Receive', 'image': 'assets/receive.svg'},
      {'title': 'Send', 'image': 'assets/send.svg'},
      {'title': 'Trade', 'image': 'assets/trade.svg'},
      {'title': 'Staking', 'image': 'assets/more.svg'},
      {'title': 'Referral', 'image': 'assets/more.svg'},
      {'title': 'International\nTransfer', 'image': 'assets/more.svg'}
    ];
    return Scaffold(
      backgroundColor: Color(0xff202428),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .07,
            ),
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            SizedBox(
              height: size.height * .03,
            ),
            Text(
              "More",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * 0.02),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            SizedBox(
              height: size.height * .4,
              width: size.width,
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: size.height * .03,
                      mainAxisExtent: size.height * .12),
                  itemCount: _cardItem.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: size.width * 0.02),
                      child: GestureDetector(
                        onTap: () {
                          if (index == 3) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const MorePage()));
                            return;
                          } else {
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
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: size.height * 0.016),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
