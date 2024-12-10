import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuwa_assignment/states/states.dart';

void main() {
  group('State Providers Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('randomWordProvider initializes with null', () {
      final randomWord = container.read(randomWordProvider);
      expect(randomWord, isNull);
    });

    test('canvasSizeProvider initializes with null', () {
      final canvasSize = container.read(canvasSizeProvider);
      expect(canvasSize, isNull);
    });

    test('prevCanvasSizeProvider initializes with null', () {
      final prevCanvasSize = container.read(prevCanvasSizeProvider);
      expect(prevCanvasSize, isNull);
    });

    test('pointsProvider initializes with empty list', () {
      final points = container.read(pointsProvider);
      expect(points, isEmpty);
    });

    test('randomWordProvider can be updated', () {
      final randomWordNotifier = container.read(randomWordProvider.notifier);
      randomWordNotifier.state = 'hello';
      final updatedWord = container.read(randomWordProvider);
      expect(updatedWord, 'hello');
    });

    test('canvasSizeProvider can be updated', () {
      final canvasSizeNotifier = container.read(canvasSizeProvider.notifier);
      canvasSizeNotifier.state = const Size(100, 100);
      final updatedCanvasSize = container.read(canvasSizeProvider);
      expect(updatedCanvasSize, const Size(100, 100));
    });

    test('prevCanvasSizeProvider can be updated', () {
      final prevCanvasSizeNotifier = container.read(
          prevCanvasSizeProvider.notifier);
      prevCanvasSizeNotifier.state = const Size(200, 200);
      final updatedPrevCanvasSize = container.read(prevCanvasSizeProvider);
      expect(updatedPrevCanvasSize, const Size(200, 200));
    });
  });
}