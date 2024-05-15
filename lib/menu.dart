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
  final topicController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double btnWidth = MediaQuery.of(context).size.width/2;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInputField(),
            const SizedBox(height: 50),
            buildPlayBtn(topicController.text)
          ],
        ),
      ),
    );
  }


  Widget buildInputField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.1,
      child: TextField(
        controller: topicController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.btnMainColor, width: 2),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.btnMainColor, width: 2),
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: 'Topic',
          fillColor: AppColor.txtMainColor,
          filled: true
        ),
        style: GoogleFonts.inknutAntiqua(
          textStyle: TextStyle(
            color: AppColor.btnDarkColor
          )
        ),
      ),
    );
  }

  Widget buildPlayBtn(String topic){
    return IconButton(
      onPressed: topic == ""
      ? null
      :  () {
        Game.resetGame();
        Game.topic = topic;
        print(">>>>GameTopic: ${Game.topic}");
        Navigator.pushAndRemoveUntil(
          context,
          GamePage.getRoute(),
          (Route<dynamic> route) => false
        );
      },
      icon: Icon(
        Icons.play_arrow_rounded,
        size: 200,
        color: AppColor.btnDarkColor,
      ),

    );
  }


}
