import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/views/Profile/contactPage.dart';
import 'package:nokuex/views/Profile/myProfileEdit.dart';
import 'package:nokuex/views/Profile/referralPage.dart';
import 'package:nokuex/views/Profile/securityPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .08,
              ),
              _top(context),
              SizedBox(
                height: size.height * .07,
              ),
              _imageCard(context),
              SizedBox(
                height: size.height * .03,
              ),
              _nameCard(context),
              SizedBox(
                height: size.height * .03,
              ),
              //my profile
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => EditProfilePage())),
                child: _cardItem(context, 'assets/user-edit.svg', 'My Profile',
                    'Your profile and personal information'),
              ),
              SizedBox(
                height: size.height * .013,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SecurityPage())),
                child: _cardItem(context, 'assets/security.svg', 'Security',
                    'Manage how you access your account'),
              ),
              SizedBox(
                height: size.height * .013,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ReferralPage()));
                },
                child: _cardItem(
                    context, 'assets/Gift.svg', 'Referral', 'Refer and earn'),
              ),
              SizedBox(
                height: size.height * .013,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ContactPage()));
                },
                child: _cardItem(context, 'assets/warning.svg', 'Help/Support',
                    'Contact us for any issue'),
              ),
              SizedBox(
                height: size.height * .013,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardItem(BuildContext context, String svg, String title, String des) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * .12,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xff282C33),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: size.width * .16,
            height: size.height * .07,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white12.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: SvgPicture.asset(svg),
            ),
          ),
          SizedBox(
            width: size.width * .02,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: size.height * 0.02),
              ),
              Text(
                des,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 207, 204, 204),
                    fontSize: size.height * 0.016),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _nameCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Ikenna',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.035),
        ),
        Text(
          'Manage your account & Preferences',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              color: const Color.fromARGB(255, 207, 204, 204),
              fontSize: size.height * 0.016),
        )
      ],
    );
  }

  Widget _top(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.grey,
          ),
        ),
        Text(
          'Logout',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              color: Colors.red,
              fontSize: size.height * 0.016),
        )
      ],
    );
  }

  Widget _imageCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          height: size.height * .12,
          width: size.width * .24,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SvgPicture.asset('assets/user.svg'),
          ),
        ),
        SizedBox(
          width: size.width * .25,
        ),
        Center(
          child: Container(
            height: size.height * .07,
            width: size.width * .15,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset('assets/Camera.svg'),
            ),
          ),
        )
      ],
    );
  }
}
