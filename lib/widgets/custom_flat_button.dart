import 'package:flutter/material.dart';
import 'package:fym_test_1/widgets/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFlatButton extends StatelessWidget {
  final void Function() onPressed;

  final String text;
  final Color color;

  CustomFlatButton({this.onPressed, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          height: 60,
          alignment: Alignment.center,
          child: Text(text,
              style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          decoration: BoxDecoration(
            color: kcprimary,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        color: Colors.transparent,
        highlightElevation: 0,
        highlightColor: Colors.grey,
        elevation: 0,
        splashColor: Colors.white);
  }
}
