import 'dart:ui';

import 'package:nuwa_assignment/models/models.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

abstract class PdfGenerator{
  static pw.Document generate(Size canvasSize, List<DrawnPoint?> points){
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.undefined,
        build: (pw.Context context) {
          return pw.Center(
              child: pw.CustomPaint(
                  size: PdfPoint(canvasSize.width, canvasSize.height),
                  painter: (canvas, size){
                    canvas
                      ..setColor(PdfColors.black)
                      ..setLineWidth(4.0)
                      ..setLineCap(PdfLineCap.round);

                    for (int i = 0; i < points.length - 1; i++) {
                      if (points[i] != null && points[i + 1] != null) {
                        canvas.drawLine(
                          points[i + 1]!.x,
                          canvasSize.height - points[i + 1]!.y,
                          points[i]!.x,
                          canvasSize.height - points[i]!.y,
                        );
                      }
                    }
                    canvas.strokePath();
                  }
              )
          ); // Center
        }
    ));
    return pdf;
  }
}