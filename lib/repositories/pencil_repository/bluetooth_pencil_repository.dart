part of 'pencil_repository.dart';

class BluetoothPencilRepository extends PencilRepository{
  BluetoothPencilRepository(super.ref);

  @override
  Future<void> connect() async {
    final bluePlus = ref.read(flutterBluePlusProvider);
    await _checkIfSupported();
    await _turnOn();
    List<BluetoothDevice> scannedDevices = [];

    // Listen to scan stream and add each discovered device to list
    bluePlus.scanResults.listen((List<ScanResult> results) {
      for (final result in results) {
        final device = result.device;
        if (!scannedDevices.contains(device)) {
          debugPrint('******${device.advName}');
          scannedDevices.add(device);
        }
      }
    });

    await bluePlus.startScan();
    await Future.delayed(const Duration(seconds: 15));
    await bluePlus.stopScan();
    debugPrint('stopped');
    for(var device in scannedDevices){
      debugPrint('******${device.advName}');
    }
    /// Leaving this for future
  }

  Future<void> _checkIfSupported() async {
    final bluePlus = ref.read(flutterBluePlusProvider);
    if (await bluePlus.isSupported == false) {
      throw BluetoothNotSupported();
    }
  }

  Future<void> _turnOn([bool throwError = false]) async{
    final bluePlus = ref.read(flutterBluePlusProvider);
    if(bluePlus.adapterStateNow == BluetoothAdapterState.on) return;

    var failedToTurnOn = false;
    try {
      await bluePlus.turnOn();
    } catch(_){
      failedToTurnOn = true;
    }
    if(failedToTurnOn && throwError) throw BluetoothOffError();
  }

  @override
  Future<Stream<BluetoothAdapterState>> state() async {
    final bluePlus = ref.read(flutterBluePlusProvider);
    await _turnOn();
    return bluePlus.adapterState;
  }
}