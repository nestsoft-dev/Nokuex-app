import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nokuex/views/withdrawal/WithdrawalMainPage.dart';
import 'package:nokuex/widgets/myButton.dart';

final stakeingPageIndexProvider = StateProvider((ref) => 0);

class StakingMainPage extends ConsumerStatefulWidget {
  const StakingMainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StakingMainPageState();
}

class _StakingMainPageState extends ConsumerState<StakingMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final pageController = PageController();
  final selectCrypto = TextEditingController();
  final enterAmount = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    pageController.dispose();
    _tabController.dispose();
    try {
      ref.watch(stakeingPageIndexProvider.notifier).state = 0;
    } catch (e) {
      print(e.toString());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.08,
            ),
            _myAppBar(context),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              height: size.height * .1,
              width: size.width,
              child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * .018),
                  dividerColor: Colors.transparent,
                  indicator: const CircleTabIndicator(
                      color: Color(0xffFF9B01), radius: 4),
                  indicatorColor: Color(0xffFF9B01),
                  tabs: const [
                    Tab(
                      text: 'Stake',
                    ),
                    Tab(
                      text: 'Earn',
                    )
                  ]),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _stakingPage(context, pageController),
                    _earnPage(context)
                  ]),
            )
          ],
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
          'Staking',
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
                  'assets/order.svg',
                  color: Colors.white,
                ),
              ),
              Text(
                'History',
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

  Widget _stakingPage(BuildContext context, PageController pagecontroller) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        return PageView(
          controller: pagecontroller,
          physics: const NeverScrollableScrollPhysics(),
          children: [_pageOne(context), _pageTwo(context)],
        );
      },
    );
  }

  Widget _pageTwo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width * .24,
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
                  'assets/btc.svg',
                  //  color: Colors.white,
                ),
              ),
              Text(
                'BTC',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: size.height * 0.016),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        _moneyBox(context),
        SizedBox(
          height: size.height * .02,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Select Duration',
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
          controller: selectCrypto,
          readOnly: true,
          keyboardType: TextInputType.number,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.03),
          decoration: InputDecoration(
              hintText: 'Select Crypto',
              suffix: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              )),
        ),
        SizedBox(
          height: size.height * .03,
        ),
        MyButton(text: 'Stake', onTap: () {})
      ],
    );
  }

  Widget _moneyBox(BuildContext context) {
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
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

  Widget _pageOne(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Select Crypto',
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
          controller: selectCrypto,
          readOnly: true,
          keyboardType: TextInputType.number,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.03),
          decoration: InputDecoration(
              hintText: 'Select Crypto',
              suffix: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              )),
        ),
        SizedBox(
          height: size.height * .03,
        ),
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
          controller: enterAmount,
          readOnly: false,
          keyboardType: TextInputType.number,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.03),
          decoration: InputDecoration(
              hintText: 'Enter Amount',
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
        ),
        SizedBox(
          height: size.height * .05,
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
      ],
    );
  }

  Widget _earnPage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Staking Earn',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * 0.025),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        //search Box
        Container(
          height: size.height * .06,
          width: size.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white12, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              Text(
                'Search',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: size.height * 0.018),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        _itemEarnCard(context),
        SizedBox(
          height: size.height * .02,
        ),
        _itemEarnCard(context),
        SizedBox(
          height: size.height * .02,
        ),
        _itemEarnCard(context),
        SizedBox(
          height: size.height * .02,
        ),
        _itemEarnCard(context),

        SizedBox(
          height: size.height * .02,
        ),
        _itemEarnCard(context),
      ],
    );
  }

  Widget _itemEarnCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //image, name
                SvgPicture.asset('assets/btc.svg'),
                SizedBox(
                  width: size.width * .03,
                ),
                Text(
                  'BTC',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: size.height * 0.016),
                ),
              ],
            ),
            Text(
              '34.37% APR',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  color: Colors.green,
                  fontSize: size.height * 0.016),
            ),
          ],
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Divider(
          color: Colors.grey.withOpacity(0.5),
        )
      ],
    );
  }
}
