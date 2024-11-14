import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/views/withdrawal/CryptoWithdrawalPage.dart';

import 'FiatWithdrawalPage.dart';

final pageIndexProvider = StateProvider((ref) => 0);

class WithdrawalMainPage extends ConsumerStatefulWidget {
  const WithdrawalMainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WithdrawalMainPageState();
}

class _WithdrawalMainPageState extends ConsumerState<WithdrawalMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    try {
      ref.watch(pageIndexProvider.notifier).state = 0;
    } catch (e) {
      print(e.toString());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final index = ref.watch(pageIndexProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .07,
            ),
            _myAppBar(context, index),
            SizedBox(
              height: size.height * .02,
            ),
            Consumer(
              builder: (context, ref, child) {
                final index = ref.watch(pageIndexProvider);
                return Text(
                  index == 0
                      ? 'Withdraw'
                      : index == 1
                          ? 'Withdraw Crypto'
                          : 'Confirm Transaction',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: size.height * 0.02),
                );
              },
            ),
            SizedBox(
              height: size.height * .1,
              width: size.width,
              child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  indicator: const CircleTabIndicator(
                      color: Color(0xffFF9B01), radius: 4),
                  indicatorColor: Color(0xffFF9B01),
                  tabs: const [
                    Tab(
                      text: 'Crypto',
                    ),
                    Tab(
                      text: 'Fiat',
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
                  children: const [
                    Cryptowithdrawalpage(),
                    Fiatwithdrawalpage()
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _myAppBar(BuildContext context, int Index) {
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
            Text(
              (Index + 1).toString(),
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * 0.02),
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

// Custom Circular Tab Indicator
class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Offset circleOffset = Offset(
      configuration.size!.width / 2 + offset.dx,
      configuration.size!.height - radius - 4,
    );

    canvas.drawCircle(circleOffset, radius, paint);
  }
}
