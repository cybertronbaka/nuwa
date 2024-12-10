part of 'errors.dart';

class BluetoothNotSupported extends Error{
  @override
  String toString() {
    return 'Bluetooth is not supported by this device';
  }
}

class BluetoothPermissionDenied extends Error{
  @override
  String toString() {
    return 'Bluetooth permissions are denied for this application';
  }
}

class BluetoothOffError extends Error{
  @override
  String toString() {
    return 'Bluetooth is turned off. Considering turning on bluetooth.';
  }
}