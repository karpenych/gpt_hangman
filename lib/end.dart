import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'game.dart';
import 'game_info.dart';
import 'menu.dart';



class EndPage extends StatefulWidget {
  const EndPage({super.key});


  static getRoute() {
    return PageRouteBuilder(
        transitionsBuilder: (_, animation, __, widget){
          return FadeTransition(opacity: animation, child: widget,);
        },
        pageBuilder: (_, __, ___) => const EndPage()
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
              Expanded(flex: 1, child: buildButtons(context, btnWidth))
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
            color: AppColor.txtMainColor,
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


}
