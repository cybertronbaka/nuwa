part of 'pencil_repository.dart';

class FakePencilRepository extends PencilRepository{
  FakePencilRepository(super.ref);

  @override
  Future<void> connect() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<Stream<BluetoothAdapterState>> state() async {
    await Future.delayed(const Duration(seconds: 1));
    return Stream.value(BluetoothAdapterState.on);
  }
}