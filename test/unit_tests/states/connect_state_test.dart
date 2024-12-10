import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuwa_assignment/models/models.dart';
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

    test('bluetoothStateProvider initalized with null', () {
      final bluetoothState = container.read(bluetoothStateProvider);
      expect(bluetoothState, isNull);
    });

    test('pencilConnectionStatusProvider initializes with disconnected', () {
      final pencilConnectionStatus = container.read(pencilConnectionStatusProvider);
      expect(pencilConnectionStatus, PencilConnectionStatus.disconnected);
    });

    test('pencilConnectionStatusProvider can be updated', () {
      final pencilConnectionStatusNotifier =
      container.read(pencilConnectionStatusProvider.notifier);

      pencilConnectionStatusNotifier.state = PencilConnectionStatus.connected;

      final updatedStatus = container.read(pencilConnectionStatusProvider);
      expect(updatedStatus, PencilConnectionStatus.connected);
    });
  });
}
