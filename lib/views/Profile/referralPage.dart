import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/constants/appconstant_data.dart';
import 'package:nokuex/server/ServerCalls.dart';
import 'package:nokuex/views/utils/myToast.dart';
import 'package:nokuex/widgets/myButton.dart';

class ReferralPage extends ConsumerWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer(builder: (_, ref, child) {
        final user = ref.watch(userProvider);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .08,
              ),
              GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.grey,
                  )),
              SizedBox(
                height: size.height * .03,
              ),
              Text(
                'Referral Program',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: size.height * 0.032),
              ),
              SizedBox(
                height: size.height * .034,
              ),
              Image.asset(
                'assets/referral.png',
                width: size.width,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: size.height * .034,
              ),
              _inviteCard(context),
              SizedBox(
                height: size.height * .034,
              ),
              Center(
                child: Text(
                  'Refer and Earn 10% commission',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: size.height * 0.023),
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Center(
                child: Text(
                  'Refer friends to Wepay app and get rewarded!\nshare your unique referral link or code and\nearn 10% offer on your next bill payment for\neach successfull referral.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: size.height * 0.014),
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              _referralCard(context, user!.referralCode ?? ''),
              SizedBox(
                height: size.height * .02,
              ),
              Center(child: MyButton(text: 'Share', onTap: () {}))
            ],
          ),
        );
      }),
    );
  }

  Widget _referralCard(BuildContext context, String referralCode) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Referal Link',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.017),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Container(
          height: size.height * .05,
          width: size.width,
          padding: EdgeInsets.all(5).copyWith(left: 10, right: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                referralCode,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: size.height * 0.013),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: referralCode));
                  successToast('Referral Code Copied');
                },
                child: Container(
                  height: size.height * .05,
                  width: size.width * .2,
                  //padding: EdgeInsets.all(5).copyWith(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: myorange, borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      'copy code',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _inviteCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: size.height * .08,
          width: size.width * .4,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your invites',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: size.height * 0.013),
              ),
              const Spacer(),
              Text(
                '(0)',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: size.height * 0.013),
              ),
            ],
          ),
        ),
        Container(
          height: size.height * .08,
          width: size.width * .4,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total EArn',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: size.height * 0.013),
              ),
              const Spacer(),
              Text(
                'NGN1,200',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: size.height * 0.013),
              ),
            ],
          ),
        )
      ],
    );
  }
}
