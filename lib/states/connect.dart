part of 'states.dart';

final bluetoothStateProvider =
    StateProvider.autoDispose<BluetoothAdapterState?>((ref) => null);

final pencilConnectionStatusProvider = StateProvider<PencilConnectionStatus>((ref){
   return PencilConnectionStatus.disconnected;
});