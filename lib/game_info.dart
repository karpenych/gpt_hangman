class Game{

  static List<String> alphabets = [
    "a", "b", "c", "d", "e", "f", "g",
    "h", "i", "j", "k", "l", "m", "n",
    "o", "p", "q", "r", "s", "t", "u",
    "v", "w", "x", "y", "z"
  ];
  static int lives = 5;
  static String topic = "";
  static String word = "";
  static List<String> wordLetters = [];
  static List<String> selectedChar = [];
  static Set<String> lettersLeft = {};

  static String startFact = "";
  static String endFact = "";

  static Set<String> generatedWords = {};
  static Set<String> generatedTopics = {};

  static void resetGame(){
    selectedChar.clear();
    lettersLeft.clear();
    wordLetters.clear();
    word = "";
    startFact = "";
    endFact = "";
    lives = 5;
    print("-----Game reseted-----");
  }


}