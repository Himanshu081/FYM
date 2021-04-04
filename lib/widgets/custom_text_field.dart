import 'package:flutter/material.dart';
import 'package:fym_test_1/widgets/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final double fontSize;
  final FontWeight fontWeight;
  final Function(String val) onChanged;
  final double height;
  final void Function(String) onSubmitted;
  final TextInputAction inputAction;
  final TextInputType keyboardType;
  final bool obscure;

  CustomTextField(
      {this.hint,
      this.fontSize,
      this.fontWeight,
      this.onChanged,
      this.height = 54.0,
      this.onSubmitted,
      this.inputAction,
      this.keyboardType,
      this.obscure});

  // final _border = OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(10.0),
  //   borderSide: BorderSide(
  //     color: Colors.black26,
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        child: TextField(
          obscureText: obscure ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          onSubmitted: onSubmitted,
          maxLengthEnforced: true,
          onChanged: onChanged,
          textInputAction: inputAction,
          cursorColor: Colors.black,
          style: GoogleFonts.openSans(
              fontSize: 12, color: kBlackColor, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 19, right: 50, bottom: 8),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: GoogleFonts.openSans(
                  fontSize: 12,
                  color: kGreyColor,
                  fontWeight: FontWeight.w600)),
        ));
  }
}
