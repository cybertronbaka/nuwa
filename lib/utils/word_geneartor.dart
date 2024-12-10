import 'dart:math';

abstract class WordGenerator {
  static const List<String> _words = [
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
    return _words[random.nextInt(_words.length)];
  }
}
