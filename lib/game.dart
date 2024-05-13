import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_hangman/letter.dart';
import 'colors.dart';
import 'dictionary.dart';
import 'end.dart';
import 'game_info.dart';



class GamePage extends StatefulWidget {
  const GamePage({super.key});


  static getRoute() {
    return PageRouteBuilder(
        transitionsBuilder: (_, animation, __, widget){
          return FadeTransition(opacity: animation, child: widget,);
        },
        pageBuilder: (_, __, ___) => const GamePage()
    );
  }


  @override
  State<GamePage> createState() => _GamePageState();
}


class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    if (Game.word == ""){
      Game.word = Dictionary.getWord(Game.topic).toLowerCase();
      Game.wordLetters = Game.word.split('');
      Game.lettersLeft = Game.wordLetters.toSet();
      if (Game.lettersLeft.contains(" ")){
        Game.lettersLeft.remove(" ");
      }
    }

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(flex: 1, child: buildLives()),
            Expanded(flex: 3, child: buildTopic()),
            Expanded(flex: 5, child: buildWord()),
            Expanded(flex: 3, child: buildKeyboard(context))
          ],
        ),
      ),
    );
  }


  Widget buildKeyboard(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 4,
      children: Game.alphabets.map((e) {
        return RawMaterialButton(
          onPressed: Game.selectedChar.contains(e)
            ? null
            : () {
              setState(() {
                Game.selectedChar.add(e);
                if (Game.lettersLeft.contains(e)){
                  Game.lettersLeft.remove(e);
                  if (Game.lettersLeft.isEmpty){
                    print("You WIN!!!!!");
                    Navigator.pushAndRemoveUntil(
                      context,
                      EndPage.getRoute(),
                      (Route<dynamic> route) => false
                    );
                  }
                } else {
                  Game.lives--;
                  if (Game.lives == 0) {
                    print("Ypu LOSE((((");
                    Navigator.pushAndRemoveUntil(
                      context,
                      EndPage.getRoute(),
                      (Route<dynamic> route) => false
                    );
                  }
                }
              });
            },
          constraints: const BoxConstraints.expand(
            width: 40,
            height: 40,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          fillColor: Game.selectedChar.contains(e)
              ? Game.wordLetters.contains(e)
                ? AppColor.btnDarkColor
                : AppColor.btnErrorColor
              : AppColor.btnLightColor,
          child: Center(
            child: Text(
              e,
              style: GoogleFonts.inknutAntiqua(
                textStyle: TextStyle(
                  color: AppColor.txtKeyboardColor,
                  fontSize: 20
                )
              ),
            ),
          ),
        );
      }).toList(),
    );
  }


  Widget buildWord() {
    return Center(
      child: Wrap(
        spacing: 8,
        runSpacing: 5,
        alignment: WrapAlignment.center,
        children: Game.wordLetters
            .map((e) => letter(e, !Game.selectedChar.contains(e)))
            .toList(),
      ),
    );
  }


  Widget buildTopic() {
    return Center(
      child: Text(
        Game.topic,
        style: GoogleFonts.inknutAntiqua(
          textStyle: TextStyle(
            color: AppColor.txtMainColor,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationThickness: 1.2,
            decorationColor: AppColor.txtMainColor
          )
        )
      ),
    );
  }


  Widget buildLives() {
    return Row(
      children: [
        Icon(
          Icons.favorite,
          color: AppColor.btnDarkColor,
          size: 50,
        ),
        Text(
          "${Game.lives}",
          style: GoogleFonts.inknutAntiqua(
            textStyle: TextStyle(
              color: AppColor.btnDarkColor,
              fontSize: 30
            )
          )
        )
      ],
    );
  }
  

}
