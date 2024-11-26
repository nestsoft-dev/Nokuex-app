import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/views/Auth/login/loginPage.dart';
import 'package:nokuex/views/Auth/registerPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/appconstant_data.dart';

final _onBoardingIndex = StateProvider((ref) => 0);

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {
  final _pageController = PageController(initialPage: 0);

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          children: [
            _topBox(context),
            _middleCard(context, _pageController),
            _bottomBox(context, _pageController),
          ],
        ),
      ),
    );
  }

  Widget _topBox(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/nokuex.png',
            height: size.height * .05,
          ),
          Text(
            'Login',
            maxLines: 1,
            style:
                TextStyle(color: Colors.white, fontSize: size.height * 0.018),
          )
        ],
      ),
    );
  }

  Widget _middleCard(BuildContext context, PageController _pageController) {
    final index = ref.watch(_onBoardingIndex);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .42,
      width: size.width,
      child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            ref.read(_onBoardingIndex.notifier).state = value;
            setState(() {
              _pageIndex = value;
            });
          },
          itemCount: onBoardingPageData.length,
          itemBuilder: (_, index) {
            return SizedBox(
              height: size.height * .38,
              width: size.width,
              child: Column(
                children: [
                  Image.asset(onBoardingPageData[index]['image'] ?? ''),
                  SizedBox(
                    height: size.height * .035,
                  ),
                  Text(
                    onBoardingPageData[index]['title'] ?? '',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: size.height * 0.028,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Text(
                    onBoardingPageData[index]['des'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.015),
                  )
                ],
              ),
            );
          },
          pageSnapping: true),
    );
  }

  Widget _bottomBox(BuildContext context, PageController _pageController) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .28,
      width: size.width,
      child: Column(
        children: [
          Consumer(builder: (context, ref, child) {
            final index = ref.watch(_onBoardingIndex);

            return SmoothPageIndicator(
                controller: _pageController, // PageController
                count: onBoardingPageData.length,
                effect: WormEffect(
                    activeDotColor: myorange,
                    dotHeight: size.height * .01,
                    dotWidth: _pageIndex == index
                        ? size.width * .07
                        : size.width * .025), // your preferred effect
                onDotClicked: (index) {});
          }),
          SizedBox(
            height: size.height * .1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buttonDesign(context, _pageController),
              SizedBox(
                height: size.height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontSize: size.height * 0.015),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const LoginPage()));
                    },
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: size.height * 0.015),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buttonDesign(BuildContext context, PageController _pageController) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (_pageIndex == 2) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const RegisterPage()));
          return;
        }
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linearToEaseOut);
        return;
      },
      child: Container(
        height: size.height * .07,
        width: size.width * .62,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(size.height * .025)),
        child: Center(
          child: Text(
            'Start Trading',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: size.height * 0.016),
          ),
        ),
      ),
    );
  }
}
