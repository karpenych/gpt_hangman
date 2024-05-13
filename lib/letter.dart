import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_hangman/colors.dart';

Widget letter(String character, bool hidden){
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: character != " "
            ? AppColor.txtKeyboardColor
            : AppColor.btnDarkColor,
          width: 2,
        )
      )
    ),
    child: Center(
      child: Visibility(
        visible: !hidden,
        child: Text(
          character,
          style: GoogleFonts.inknutAntiqua(
            textStyle: TextStyle(
              color: AppColor.txtMainColor,
              fontSize: 30
            )
          ),
        ),
      ),
    ),
  );
}