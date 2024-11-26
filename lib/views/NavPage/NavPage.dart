import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nokuex/views/Trade/tradePage.dart';
import 'package:nokuex/views/card/CardPage.dart';
import 'package:nokuex/views/home/homepage.dart';
import 'package:nokuex/views/stack/stakingPage.dart';

class NavPage extends ConsumerStatefulWidget {
  const NavPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavPageState();
}

class _NavPageState extends ConsumerState<NavPage> {
  final List<Widget> _screen = [
    const HomePage(),
    const CardPage(),
    const TradeMainPage(),
    const StakingMainPage(),
  ];

  int index = 0;
  void onTap(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff202428),
      body: _screen[index],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff202428),
          currentIndex: index,
          onTap: onTap,
          selectedIconTheme: const IconThemeData(color: Color(0xffFF9B01)),
          selectedItemColor: const Color(0xffFF9B01),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: false,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/home.svg',
                  color: index == 0 ? Color(0xffFF9B01) : Colors.grey,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/d_card.svg',
                  color: index == 1 ? Color(0xffFF9B01) : Colors.grey,
                ),
                label: 'Card'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/d_history.svg',
                  color: index == 2 ? Color(0xffFF9B01) : Colors.grey,
                ),
                label: 'Trade'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/d_profile.svg',
                  color: index == 3 ? Color(0xffFF9B01) : Colors.grey,
                ),
                label: 'Profile'),
          ]),
    );
  }
}
