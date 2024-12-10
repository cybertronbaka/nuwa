import 'package:flutter_test/flutter_test.dart';
import 'package:nuwa_assignment/utils/word_geneartor.dart';

void main() {
  group('WordGenerator', () {
    test('generate returns a word from the predefined list', () {
      final word = WordGenerator.generate();
      expect(WordGenerator.words.contains(word), isTrue);
    });

    test('generate does not repeat the same word consecutively', () {
      final firstWord = WordGenerator.generate();
      final secondWord = WordGenerator.generate();
      expect(firstWord, isNot(equals(secondWord)));
    });
  });
}
