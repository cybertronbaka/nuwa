import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuwa_assignment/app/app.dart';
import 'package:nuwa_assignment/pages/connect/page.dart';
import 'package:nuwa_assignment/pages/write/page.dart';
import 'package:nuwa_assignment/repositories/pencil_repository/pencil_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ConnectCard Button Action Test', (WidgetTester tester) async {

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pencilRepoProvider.overrideWith((ref) => FakePencilRepository(ref))
        ],
        child: MaterialApp(
          home: Consumer(
            builder: (context, ref, _){
              return const ConnectPage();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Connect Stylus'), findsOneWidget);

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('Connect Stylus'), findsNothing);
    expect(find.text('Connecting...'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 10));

    expect(find.text('Connecting...'), findsNothing);
    expect(find.text('Connected'), findsOneWidget);
  });

  testWidgets('ConnectCard Button Connected Test', (WidgetTester tester) async {

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pencilRepoProvider.overrideWith((ref) => FakePencilRepository(ref))
        ],
        child: MaterialApp(
          routes: {
            '/': (context) => Consumer(
              builder: (context, ref, _){
                return const ConnectPage();
              },
            ),
            Routes.write: (context) => const WritePage(),
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Connect Stylus'), findsOneWidget);

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(find.text('Connect Stylus'), findsNothing);
    expect(find.text('Connecting...'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 10));

    expect(find.text('Connecting...'), findsNothing);
    expect(find.text('Connected'), findsOneWidget);
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(find.text('Data Collection: Using stylus'), findsOneWidget);
  });
}
