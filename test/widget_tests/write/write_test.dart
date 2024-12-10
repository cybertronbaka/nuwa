import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nuwa_assignment/app/app.dart';
import 'package:nuwa_assignment/models/models.dart';
import 'package:nuwa_assignment/pages/write/page.dart';
import 'package:nuwa_assignment/repositories/pencil_repository/pencil_repository.dart';
import 'package:nuwa_assignment/states/states.dart';
import 'package:nuwa_assignment/utils/file_utils.dart';
import 'package:nuwa_assignment/widgets/widgets.dart';

class MockFileUtils extends Mock implements FileUtils{}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  final fileUtils = MockFileUtils();

  setUp((){
    registerFallbackValue(Uint8List.fromList([]));
  });
  testWidgets('WritePage Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pencilRepoProvider.overrideWith((ref) => FakePencilRepository(ref)),
          pencilConnectionStatusProvider.overrideWith((ref) => PencilConnectionStatus.connected)
        ],
        child: MaterialApp(
          home: Consumer(
            builder: (context, ref, _){
              return const WritePage();
            },
          ),
        ),
      ),
    );

    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(Footer), findsOneWidget);

    expect(find.text('Connected'), findsOneWidget);
  });

  testWidgets('WritePage Disconnected Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pencilRepoProvider.overrideWith((ref) => FakePencilRepository(ref)),
          pencilConnectionStatusProvider.overrideWith((ref) => PencilConnectionStatus.disconnected)
        ],
        child: MaterialApp(
          home: Consumer(
            builder: (context, ref, _){
              return const WritePage();
            },
          ),
        ),
      ),
    );

    expect(find.text('Disconnected'), findsOneWidget);
    final text = find.text('Disconnected').evaluate().single.widget as Text;
    expect(text.style?.color, NuwaColors.black);
  });

  testWidgets('WritePage Reset Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pencilRepoProvider.overrideWith((ref) => FakePencilRepository(ref)),
          pencilConnectionStatusProvider.overrideWith((ref) => PencilConnectionStatus.connected)
        ],
        child: MaterialApp(
          home: Consumer(
            builder: (context, ref, _){
              return const WritePage();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('generatedText')), findsOneWidget);
    final oldText = find.byKey(const Key('generatedText')).evaluate().single.widget as Text;
    await tester.tap(find.byKey(const Key('refreshBtn')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('generatedText')), findsOneWidget);
    final newText = find.byKey(const Key('generatedText')).evaluate().single.widget as Text;
    expect(newText, isNot(oldText));
  });

  testWidgets('Test drawing on canvas, export and Reset', (WidgetTester tester) async {
    WidgetRef? widgetRef;

    when(() => fileUtils.writeFile(any(), any())).thenAnswer((_) async {
      return File('test');
    });
    when(() => fileUtils.openPdf(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pencilRepoProvider.overrideWith((ref) => FakePencilRepository(ref)),
          pencilConnectionStatusProvider.overrideWith((ref) => PencilConnectionStatus.connected),
          fileUtilsProvider.overrideWithValue(fileUtils),
        ],
        child: MaterialApp(
          home: Consumer(
            builder: (context, ref, _){
              widgetRef = ref;

              return const WritePage();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Draw
    final canvasFinder = find.byKey(const Key('Canvas'));
    expect(canvasFinder, findsOneWidget);

    final topLeft = tester.getTopLeft(canvasFinder);
    final gesture = await tester.startGesture(topLeft);
    await gesture.moveBy(const Offset(10, 10));
    await tester.pump();
    await gesture.moveBy(const Offset(0, 10));
    await tester.pump();
    await gesture.moveBy(const Offset(0, 10));
    await tester.pump();

    final points = widgetRef!.read(pointsProvider);
    expect(points.isNotEmpty, true);

    await gesture.moveBy(const Offset(10, 0));
    await tester.pump();

    final newPoints = widgetRef!.read(pointsProvider);
    expect(newPoints.length, greaterThan(points.length));

    await gesture.up();
    await tester.pump();
    expect(widgetRef!.read(pointsProvider).last, isNull);

    // Export
    final exportBtnFinder = find.byKey(const Key('exportToPDF'));
    expect(exportBtnFinder, findsOneWidget);
    await tester.tap(exportBtnFinder);
    await tester.pumpAndSettle();
    // Reset
    expect(find.byKey(const Key('generatedText')), findsOneWidget);
    final oldText = find.byKey(const Key('generatedText')).evaluate().single.widget as Text;
    await tester.tap(find.byKey(const Key('refreshBtn')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('generatedText')), findsOneWidget);
    final newText = find.byKey(const Key('generatedText')).evaluate().single.widget as Text;
    expect(newText, isNot(oldText));
  });
}
