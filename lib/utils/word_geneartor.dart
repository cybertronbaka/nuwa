import 'dart:math';

var _index = 0;

abstract class WordGenerator {
  static const List<String> words = [
    'apple',
    'banana',
    'cherry',
    'dog',
    'elephant',
    'flower',
    'giraffe',
    'house',
    'island',
    'jungle',
    'kite',
    'lemon',
    'mountain',
    'notebook',
    'ocean',
    'pencil',
    'queen',
    'river',
    'sunshine',
    'tree',
    'umbrella',
    'violin',
    'waterfall',
    'xylophone',
    'yacht',
    'zebra',
  ];

  static String generate() {
    final random = Random();
    var index = random.nextInt(words.length);
    while(index == _index){
      index = random.nextInt(words.length);
    }
    return words[index];
  }
}
