import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInput extends StatelessWidget {
  const MyInput({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.isPassword,
    this.suffix,
    required this.type,
    this.isReadonly = false,
  });
  final String title, hint;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? suffix;
  final TextInputType type;
  final bool? isReadonly;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: size.height * .016),
        ),
        SizedBox(
          height: size.height * .012,
        ),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: type,
          obscuringCharacter: '*',
          cursorColor: Colors.white,
          readOnly: isReadonly!,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              suffix: suffix,
              filled: true,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              fillColor: Colors.grey.withOpacity(0.15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(size.height * .015))),
        )
      ],
    );
  }
}
