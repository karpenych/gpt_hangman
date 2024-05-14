class Game{
  static String API_TOKEN = "AQVNyhK4fJ-LSsZORt7GSS5AKdUQ6Uf8daTABHF5";
  static String FOLDER_ID = "b1gsusfmgj8lasim5eaf";

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
    print("-----Game reseted-----");
  }


}