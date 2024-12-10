import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuwa_assignment/repositories/pencil_repository/pencil_repository.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        pencilRepoProvider.overrideWith((ref) => FakePencilRepository(ref))
      ]
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('connect completes after a 2-second delay', () async {
    final stopwatch = Stopwatch()..start();
    await container.read(pencilRepoProvider).connect();
    stopwatch.stop();
    expect(stopwatch.elapsed.inSeconds, greaterThanOrEqualTo(2));
  });

  test('state returns a stream with BluetoothAdapterState.on after 1 second', () async {
    final stopwatch = Stopwatch()..start();
    final stateStream = await container.read(pencilRepoProvider).state();
    stopwatch.stop();
    expect(stopwatch.elapsed.inSeconds, greaterThanOrEqualTo(1));
    expect(await stateStream.first, BluetoothAdapterState.on);
  });
}
