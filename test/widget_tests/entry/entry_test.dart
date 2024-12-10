import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nuwa_assignment/app/app.dart';
import 'package:nuwa_assignment/models/models.dart';
import 'package:nuwa_assignment/pages/connect/page.dart';
import 'package:nuwa_assignment/pages/entry/page.dart';
import 'package:nuwa_assignment/repositories/pencil_repository/pencil_repository.dart';
import 'package:nuwa_assignment/states/states.dart';
import 'package:nuwa_assignment/widgets/widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp((){
    registerFallbackValue(Uint8List.fromList([]));
  });
  testWidgets('EntryPage Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pencilRepoProvider.overrideWith((ref) => FakePencilRepository(ref)),
          pencilConnectionStatusProvider.overrideWith((ref) => PencilConnectionStatus.disconnected)
        ],
        child: MaterialApp(
          routes: {
            '/': (context) => Consumer(
              builder: (context, ref, _){
                return const EntryPage();
              },
            ),
            Routes.connect: (context) => const ConnectPage(),
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(Footer), findsOneWidget);

    expect(find.text('Data Collection and Testing Tool'), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
    await tester.scrollUntilVisible(find.byType(FilledButton), 2);
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(find.text('Data Collection and Testing Tool'), findsNothing);
    expect(find.text('Connect Stylus'), findsOneWidget);
  });
}
