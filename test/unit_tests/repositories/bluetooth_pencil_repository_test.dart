import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nuwa_assignment/errors/errors.dart';
import 'package:nuwa_assignment/misc/blue_plus_mockable.dart';
import 'package:nuwa_assignment/repositories/pencil_repository/pencil_repository.dart';

class MockFlutterBluePlusMockable extends Mock implements FlutterBluePlusMockable {}

class MockRef extends Mock implements Ref {}

void main() {
  late ProviderContainer container;
  late MockFlutterBluePlusMockable mockFlutterBluePlus;

  setUp(() {
    mockFlutterBluePlus = MockFlutterBluePlusMockable();

    container = ProviderContainer(overrides: [
      flutterBluePlusProvider.overrideWith((_) => mockFlutterBluePlus),
      pencilRepoProvider.overrideWith((ref) => BluetoothPencilRepository(ref))
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('BluetoothPencilRepository', () {
    test('connect scans for devices and stops scan after 15 seconds', () async {
      when(() => mockFlutterBluePlus.scanResults)
          .thenAnswer((_) => Stream.value([]));
      when(() => mockFlutterBluePlus.startScan()).thenAnswer((_) async {});
      when(() => mockFlutterBluePlus.stopScan()).thenAnswer((_) async {});
      when(() => mockFlutterBluePlus.isSupported).thenAnswer((_) async => true);
      when(() => mockFlutterBluePlus.adapterStateNow).thenReturn(BluetoothAdapterState.on);

      await container.read(pencilRepoProvider).connect();

      verify(() => mockFlutterBluePlus.startScan()).called(1);
      verify(() => mockFlutterBluePlus.stopScan()).called(1);
      verifyNever(() => mockFlutterBluePlus.turnOn());
    });

    test('_checkIfSupported throws BluetoothNotSupported if not supported', () async {
      when(() => mockFlutterBluePlus.isSupported).thenAnswer((_) async => false);

      expect(() => container.read(pencilRepoProvider).connect(),
        throwsA(isA<BluetoothNotSupported>()),
      );
    });

    test('_turnOn calls turnOn if adapter is off', () async {
      when(() => mockFlutterBluePlus.scanResults)
          .thenAnswer((_) => Stream.value([]));
      when(() => mockFlutterBluePlus.isSupported).thenAnswer((_) async => true);
      when(() => mockFlutterBluePlus.adapterStateNow)
          .thenReturn(BluetoothAdapterState.off);
      when(() => mockFlutterBluePlus.startScan()).thenAnswer((_) async => true);
      when(() => mockFlutterBluePlus.stopScan()).thenAnswer((_) async => true);
      when(() => mockFlutterBluePlus.turnOn()).thenAnswer((_) async {});

      await container.read(pencilRepoProvider).connect();

      verify(() => mockFlutterBluePlus.turnOn()).called(1);
    });

    test('state returns adapter state stream', () async {
      final adapterStateStream = Stream.value(BluetoothAdapterState.on);
      when(() => mockFlutterBluePlus.adapterState)
          .thenAnswer((_) => adapterStateStream);
      when(() => mockFlutterBluePlus.adapterStateNow)
          .thenReturn(BluetoothAdapterState.on);

      final stateStream = await container.read(pencilRepoProvider).state();

      expect(await stateStream.first, BluetoothAdapterState.on);
    });
  });
}
