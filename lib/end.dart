import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'game.dart';
import 'game_info.dart';
import 'gpt_settings.dart';
import 'menu.dart';



class EndPage extends StatefulWidget {
  final bool isWin;
  const EndPage(this.isWin, {super.key});

  static getRoute(bool isWin) {
    return PageRouteBuilder(
        transitionsBuilder: (_, animation, __, widget){
          return FadeTransition(opacity: animation, child: widget,);
        },
        pageBuilder: (_, __, ___) => EndPage(isWin)
    );
  }

  @override
  State<EndPage> createState() => _EndPageState();
}


class _EndPageState extends State<EndPage> {
  @override
  Widget build(BuildContext context) {
    double btnWidth = MediaQuery.of(context).size.width/3;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: printWord()),
              Expanded(flex: 8, child: generateEndFact()),
              Expanded(flex: 2, child: buildButtons(context, btnWidth))
            ],
          ),
        ),
      ),
    );
  }


  Widget printWord() {
    return Center(
      child: Text(
        Game.word,
        textAlign: TextAlign.center,
        style: GoogleFonts.inknutAntiqua(
          textStyle: TextStyle(
            fontSize: 50,
            color: widget.isWin ? AppColor.txtWinColor : AppColor.btnErrorColor,
            fontWeight: FontWeight.bold,
          )
        )
      ),
    );
  }


  Widget buildButtons(BuildContext context, double btnWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: (){
            Game.resetGame();
            Navigator.pushAndRemoveUntil(
              context,
              GamePage.getRoute(),
              (Route<dynamic> route) => false
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.btnMainColor,
            foregroundColor: AppColor.txtMainColor,
            fixedSize: Size.fromWidth(btnWidth)
          ),
          child: Text("Play again", style: GoogleFonts.inknutAntiqua(),)
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                context,
                MenuPage.getRoute(),
                (Route<dynamic> route) => false
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.btnDarkColor,
              foregroundColor: AppColor.txtMainColor,
              fixedSize: Size.fromWidth(btnWidth)
            ),
            child: Text("Menu", style: GoogleFonts.inknutAntiqua(),)
        ),
      ],

    );
  }


  Widget generateEndFact() {
    return FutureBuilder(
      future: Gpt.generateEndFact(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text(
              "error: ${snapshot.error.toString()}(((",
              textAlign: TextAlign.center,
              style: GoogleFonts.inknutAntiqua(
                textStyle: TextStyle(
                  color: AppColor.btnErrorColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                )
              )
            ),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          Game.endFact = snapshot.data.toString().trim();
          return Center(
            child: Text(
              Game.endFact,
              textAlign: TextAlign.center,
              style: GoogleFonts.inknutAntiqua(
                textStyle: TextStyle(
                  color: AppColor.txtMainColor,
                  fontSize: 16,
                )
              )
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }



}
