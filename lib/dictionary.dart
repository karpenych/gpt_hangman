import 'dart:math';



class Dictionary {
  static List<String> flora = [
    "palm",
    "dandelion",
    "moss",
    "wolfsbane",
    "birch"
  ];
  static List<String> fauna = [
    "gorilla",
    "capybara",
    "savanna",
    "panda",
    "blue whale"
  ];
  static List<String> geography = [
    "russia",
    "ireland",
    "united kingdom",
    "africa",
    "pacific ocean"
  ];

  static String getWord(String topic){
    if (topic.toLowerCase() == "flora"){
      int randomIndex = Random().nextInt(flora.length);
      return flora[randomIndex];
    }
    if (topic.toLowerCase() == "fauna"){
      int randomIndex = Random().nextInt(fauna.length);
      return fauna[randomIndex];
    }
    if (topic.toLowerCase() == "geography"){
      int randomIndex = Random().nextInt(geography.length);
      return geography[randomIndex];
    }
    return "";
  }
}
