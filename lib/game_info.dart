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

  static void resetGame(){
    selectedChar.clear();
    lettersLeft.clear();
    wordLetters.clear();
    word = "";
    lives = 5;
  }
}