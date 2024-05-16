import 'package:http/http.dart' as http;
import 'dart:convert';
import 'game_info.dart';



class Gpt {
  static String API_TOKEN = "AQVNyhK4fJ-LSsZORt7GSS5AKdUQ6Uf8daTABHF5";
  static String FOLDER_ID = "b1gsusfmgj8lasim5eaf";

  static double temperature = 0.6;

  static Future<String> generateWordGPT() async{
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Api-Key $API_TOKEN",
      "x-folder-id": FOLDER_ID
    };
    var body = jsonEncode(
        {
          "modelUri": "gpt://$FOLDER_ID/yandexgpt",
          "completionOptions": {
            "stream": false,
            "temperature": Gpt.temperature,
            "maxTokens": 100,
          },
          "messages": [
            {
              "role": "system",
              "text": "У тебя есть безграничный запас слов на любые темы. Я буду говорить тебе тему на английском, а ты будешь загадывать мне любое слово на эту тему, состоящее из одного или двух слов. Формат ответа - просто загаданное слово на английском, слово должно быть без специальных символов и знаков пунктуации. Слова которые тебе нельзя использовать: ${Game.generatedWords.join(", ")}. Эти слова тебе загадывать нельзя.",
            },
            {
              "role": "user",
              "text": "Загадай мне слово на тему ${Game.topic}"
            }
          ]
        }
    );
    var response = await http.post(
        Uri.parse("https://llm.api.cloud.yandex.net/foundationModels/v1/completion"),
        headers: headers,
        body: body
    );

    print(">>>>Post info:");
    print(">>>>Body: $body");
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


  static Future<String> generateTopicGPT() async{
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Api-Key $API_TOKEN",
      "x-folder-id": FOLDER_ID
    };
    var body = jsonEncode(
        {
          "modelUri": "gpt://$FOLDER_ID/yandexgpt",
          "completionOptions": {
            "stream": false,
            "temperature": Gpt.temperature,
            "maxTokens": 100,
          },
          "messages": [
            {
              "role": "system",
              "text": "Я играю с тобой в игру 'Угадай слово'. Ты выбираешь мне тему, на которую будут загаданы слова. Формат ответа - просто выбранная тема на английском, слово должно быть без специальных символов и знаков пунктуации. Темы которые тебе нельзя использовать: ${Game.generatedTopics.join(", ")}. Эти темы тебе загадывать нельзя.",
            },
            {
              "role": "user",
              "text": "Загадай мне тему"
            }
          ]
        }
    );
    var response = await http.post(
        Uri.parse("https://llm.api.cloud.yandex.net/foundationModels/v1/completion"),
        headers: headers,
        body: body
    );

    print(">>>>Post info:");
    print(">>>>Body: $body");
    print(">>>>>>StatusCode: ${response.statusCode}");

    if (response.statusCode == 200) {
      print(">>>>Full answer: ${jsonDecode(response.body)}");
      final answer = jsonDecode(response.body)["result"]["alternatives"][0]["message"]["text"];
      print(">>>>Answer: $answer");
      return answer;
    } else {
      print(">>>>generateTopicGPT Error: ${response.reasonPhrase}");
      throw Exception();
    }
  }


  static Future<String> generateStartFact() async{
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Api-Key $API_TOKEN",
      "x-folder-id": FOLDER_ID
    };
    var body = jsonEncode(
        {
          "modelUri": "gpt://$FOLDER_ID/yandexgpt",
          "completionOptions": {
            "stream": false,
            "temperature": Gpt.temperature,
            "maxTokens": 500,
          },
          "messages": [
            {
              "role": "system",
              "text": "Ты знаешь много интересных фактов обо всём. Я буду говрить тебе слово на английском, а ты будешь давать мне факт на английском о нём. Формат ответа - факт на английском, где все вхождения загаданного слова в любой его форме в факте надо заменить на '...'. Повторяю, все вхождения загаданного слова в любой его форме должны быть заменены на '...'",
            },
            {
              "role": "user",
              "text": "Дай мне маленький факт о ${Game.word}. Напоминаю, замени все вхождения слова ${Game.word} в любой его форме на '...'"
            }
          ]
        }
    );
    var response = await http.post(
        Uri.parse("https://llm.api.cloud.yandex.net/foundationModels/v1/completion"),
        headers: headers,
        body: body
    );

    print(">>>>Post info:");
    print(">>>>Body: $body");
    print(">>>>>>StatusCode: ${response.statusCode}");

    if (response.statusCode == 200) {
      print(">>>>Full answer: ${jsonDecode(response.body)}");
      final answer = jsonDecode(response.body)["result"]["alternatives"][0]["message"]["text"];
      print(">>>>Answer: $answer");
      return answer;
    } else {
      print(">>>>generateTopicGPT Error: ${response.reasonPhrase}");
      throw Exception();
    }
  }


}