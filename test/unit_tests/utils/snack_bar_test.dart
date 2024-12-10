import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuwa_assignment/utils/snackbar.dart';

void main() {
  group('CustomSnackBar', () {
    testWidgets('shows error notification', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    CustomSnackBar.showErrorNotification(
                        context, 'Error occurred');
                  },
                  child: const Text('Show Error SnackBar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Error SnackBar'));
      await tester.pump();

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Error occurred'), findsOneWidget);
    });

    testWidgets('shows success notification', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    CustomSnackBar.showSuccessNotification(
                        context, 'Operation successful');
                  },
                  child: const Text('Show Success SnackBar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Success SnackBar'));
      await tester.pump();

      expect(find.byIcon(Icons.done), findsOneWidget);
      expect(find.text('Operation successful'), findsOneWidget);
    });

    testWidgets('shows info notification', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    CustomSnackBar.showInfoNotification(
                        context, 'Here is some info');
                  },
                  child: const Text('Show Info SnackBar'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Info SnackBar'));
      await tester.pump();

      expect(find.byIcon(Icons.info_outline), findsOneWidget);
      expect(find.text('Here is some info'), findsOneWidget);
    });
  });
}
