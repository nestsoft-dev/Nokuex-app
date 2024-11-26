import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/views/Auth/widgets/textInput.dart';
import 'package:nokuex/widgets/myButton.dart';

class EditProfilePage extends ConsumerWidget {
  EditProfilePage({super.key});
  final firstName = TextEditingController(text: 'Obetta');
  final lastName = TextEditingController(text: 'ikenna');
  final email = TextEditingController(text: 'obettaikenna19@gmail.com');
  final number = TextEditingController(text: '9138473122');
  String countryCode = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.08,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Text(
              'My Profile',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: size.height * 0.03),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            MyInput(
                title: 'First Name',
                hint: 'First Name',
                controller: firstName,
                isPassword: false,
                type: TextInputType.text),
            SizedBox(
              height: size.height * .02,
            ),
            MyInput(
                title: 'Last Name',
                hint: 'last Name',
                controller: lastName,
                isPassword: false,
                type: TextInputType.text),
            SizedBox(
              height: size.height * .02,
            ),
            MyInput(
                title: 'Email Address',
                hint: 'First Name',
                controller: email,
                isPassword: false,
                isReadonly: true,
                type: TextInputType.text),
            SizedBox(
              height: size.height * .02,
            ),
            //number
            Text(
              'Phone Number',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: size.height * .016),
            ),
            SizedBox(
              height: size.height * .012,
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20).copyWith(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.withOpacity(0.15)),
                    child: Center(
                      child: Row(
                        children: [
                          CountryCodePicker(
                            textStyle: TextStyle(color: Colors.grey),
                            backgroundColor: Colors.black,
                            onChanged: (val) {
                              //  setState(() {
                              countryCode = val.dialCode!;
                              // });
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'IT',
                            favorite: ['+39', 'FR'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  controller: number,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  obscuringCharacter: '*',
                  cursorColor: Colors.white,
                  maxLength: 10,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      hintText: '+234',
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.grey.withOpacity(0.15),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.height * .015))),
                ))
              ],
            ),
            SizedBox(
              height: size.height * .035,
            ),
            Center(
              child: MyButton(text: 'Update', onTap: () {}),
            )
          ],
        ),
      ),
    );
  }
}
