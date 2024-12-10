part of 'pencil_repository.dart';

class BluetoothPencilRepository extends PencilRepository{
  @override
  Future<void> connect() async {
    await _checkIfSupported();
    await _turnOn();
    List<BluetoothDevice> scannedDevices = [];

    // Listen to scan stream and add each discovered device to list
    FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
      for (final result in results) {
        final device = result.device;
        if (!scannedDevices.contains(device) && device.localName.isNotEmpty) {
          print('******${device.advName}');
          scannedDevices.add(device);
        }
      }
    });

    await FlutterBluePlus.startScan();
    await Future.delayed(const Duration(seconds: 15));
    await FlutterBluePlus.stopScan();
    print('stopped');
    for(var device in scannedDevices){
      print('******${device.advName}');
    }
    /// Leaving this for future
  }

  Future<void> _checkIfSupported() async {
    if (await FlutterBluePlus.isSupported == false) {
      throw BluetoothNotSupported();
    }
  }

  Future<void> _turnOn([bool throwError = false]) async{
    if(FlutterBluePlus.adapterStateNow == BluetoothAdapterState.on) return;

    var failedToTurnOn = false;
    try {
      await FlutterBluePlus.turnOn();
    } catch(_){
      failedToTurnOn = true;
    }
    if(failedToTurnOn && throwError) throw BluetoothOffError();
  }

  @override
  Future<Stream<BluetoothAdapterState>> state() async {
    await _turnOn();
    return FlutterBluePlus.adapterState;
  }
}