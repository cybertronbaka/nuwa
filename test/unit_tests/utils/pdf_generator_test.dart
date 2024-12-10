import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuwa_assignment/utils/pdf_generator.dart';
import 'package:nuwa_assignment/models/models.dart';

void main() {
  group('PdfGenerator', () {
    test('generates a PDF document', () {
      const canvasSize = Size(500, 700);
      const points = [
        DrawnPoint(100,100, 100),
        DrawnPoint(200,200, 101),
        DrawnPoint(300,300, 102),
        null,
        DrawnPoint(150,150, 104),
      ];

      final pdf = PdfGenerator.generate(canvasSize, points);

      final pages = pdf.document.pdfPageList.pages;
      expect(pages.length, equals(1));
    });

    test('handles empty points list', () {
      const canvasSize = Size(500, 700);
      final points = <DrawnPoint?>[];

      final pdf = PdfGenerator.generate(canvasSize, points);
      final pages = pdf.document.pdfPageList.pages;

      expect(pages.length, equals(1));
    });

    test('handles null points gracefully', () {
      const canvasSize = Size(500, 700);
      final points = [null, null, null];

      final pdf = PdfGenerator.generate(canvasSize, points);
      final pages = pdf.document.pdfPageList.pages;

      expect(pages.length, equals(1));
    });
  });
}
