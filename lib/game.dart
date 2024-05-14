import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:gpt_hangman/letter.dart';
import 'colors.dart';
import 'end.dart';
import 'game_info.dart';
import 'menu.dart';



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
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Game.word == ""
          ? startNewGame()
          : buildGameScreen()
      ),
    );
  }


  Widget buildGameScreen(){
    return Column(
      children: [
        Expanded(flex: 1, child: buildLives()),
        Expanded(flex: 3, child: buildTopic()),
        Expanded(flex: 5, child: buildWord()),
        Expanded(flex: 3, child: buildKeyboard(context))
      ],
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
        textAlign: TextAlign.center,
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
          color: Game.lives > 0 ? AppColor.btnDarkColor : AppColor.txtMainColor,
          size: 50,
        ),
        Icon(
          Icons.favorite,
          color: Game.lives > 1 ? AppColor.btnDarkColor : AppColor.txtMainColor,
          size: 50,
        ),
        Icon(
          Icons.favorite,
          color: Game.lives > 2 ? AppColor.btnDarkColor : AppColor.txtMainColor,
          size: 50,
        ),
        Icon(
          Icons.favorite,
          color: Game.lives > 3 ? AppColor.btnDarkColor : AppColor.txtMainColor,
          size: 50,
        ),
        Icon(
          Icons.favorite,
          color: Game.lives > 4 ? AppColor.btnDarkColor : AppColor.txtMainColor,
          size: 50,
        ),
      ],
    );
  }


  Widget startNewGame() {
    return FutureBuilder(
      future: generateWordGPT(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SORRY, ERROR",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      textStyle: TextStyle(
                        color: AppColor.btnErrorColor,
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MenuPage.getRoute(),
                        (Route<dynamic> route) => false
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.btnErrorColor,
                      foregroundColor: AppColor.btnDarkColor,
                      fixedSize: Size.fromWidth(MediaQuery.of(context).size.width/3)
                    ),
                    child: Text("Menu", style: GoogleFonts.inknutAntiqua(),)
                  ),
                ],
              )
            ),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          Game.word = snapshot.data.toString().toLowerCase().trim().replaceAll(RegExp(r'[^\w\s]+'), '');
          Game.wordLetters = Game.word.split('');
          Game.lettersLeft = Game.wordLetters.toSet();
          if (Game.lettersLeft.contains(" ")){
            Game.lettersLeft.remove(" ");
          }
          return buildGameScreen();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }


  Future<String> generateWordGPT() async{
    var response = await http.post(
      Uri.parse("https://llm.api.cloud.yandex.net/foundationModels/v1/completion"),
      headers:
        {
          "Content-type": "application/json",
          "Authorization": "Api-Key ${Game.API_TOKEN}",
          "x-folder-id": Game.FOLDER_ID
        },
      body: jsonEncode(
        {
          "modelUri": "gpt://${Game.FOLDER_ID}/yandexgpt",
          "completionOptions": {
            "stream": true,
            "temperature": 0.3,
            "maxTokens": 100,
          },
          "messages": [
            {
              "role": "system",
              "text": "У тебя есть безграничный запас слов на любые темы. Я буду говорить тебе тему на английском, а ты будешь загадывать мне любое слово на эту тему, состоящее из одного или двух слов. Формат ответа - просто загаданное слово на английском без специальных символов и знаков пунктуации"
            },
            {
              "role": "user",
              "text": "Загадай мне слово на тему ${Game.topic}"
            }
          ]
        }
      )
    );

    print(">>>>Post info:");
    print(">>>>>>StatusCode: ${response.statusCode}");

    if (response.statusCode == 200) {
      print(">>>>Full answer: ${jsonDecode(response.body)}");
      final answer = jsonDecode(response.body)["result"]["alternatives"][0]["message"]["text"];
      print(">>>>Answer: $answer");
      return answer;
    } else {
      print(">>>>generateWordGPT Error: ${response.reasonPhrase}");
      throw Exception();
    }
  }


}
