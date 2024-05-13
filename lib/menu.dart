import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_hangman/game.dart';
import 'colors.dart';
import 'game_info.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'GPT Wordsmith Challenge',
      home: MenuPage(),
    );
  }
}


class MenuPage extends StatefulWidget {
  const MenuPage({super.key});


  static getRoute() {
    return PageRouteBuilder(
        transitionsBuilder: (_, animation, __, widget){
          return FadeTransition(opacity: animation, child: widget,);
        },
        pageBuilder: (_, __, ___) => const MenuPage()
    );
  }


  @override
  State<MenuPage> createState() => _MenuPageState();
}


class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    double btnWidth = MediaQuery.of(context).size.width/2;
    Game.resetGame();

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "GPT Wordsmith Challenge",
          style: GoogleFonts.knewave(
            textStyle: TextStyle(
              color: AppColor.txtMainColor
            )
          )
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(flex: 1, child: buildButtons(context, btnWidth))
          ],
        ),
      ),
    );
  }


  Column buildButtons(BuildContext context, double btnWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: (){
            Game.topic = "Flora";
            Navigator.pushAndRemoveUntil(
              context,
              GamePage.getRoute(),
              (Route<dynamic> route) => false
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.btnLightColor,
            foregroundColor: AppColor.txtMainColor,
            fixedSize: Size.fromWidth(btnWidth)
          ),
          child: Text("Flora", style: GoogleFonts.inknutAntiqua(),)
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: (){
            Game.topic = "Fauna";
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
          child: Text("Fauna", style: GoogleFonts.inknutAntiqua(),)
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: (){
            Game.topic = "Geography";
            Navigator.pushAndRemoveUntil(
              context,
              GamePage.getRoute(),
              (Route<dynamic> route) => false
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.btnDarkColor,
            foregroundColor: AppColor.txtMainColor,
            fixedSize: Size.fromWidth(btnWidth)
          ),
          child: Text("Geography",style: GoogleFonts.inknutAntiqua(),)
        ),
      ],
    );
  }
}
