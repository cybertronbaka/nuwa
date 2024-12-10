part of 'page.dart';

class _ConnectionStatus extends ConsumerWidget{
  const _ConnectionStatus();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bluetoothState = ref.watch(bluetoothStateProvider);

    if(bluetoothState == null) {
      return const SizedBox(height: 20, width: 20, child: CircularProgressIndicator());
    }

    return bluetoothState.message == null ? Container()
      : Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: NuwaColors.error,
          borderRadius: BorderRadius.circular(12),
        ),
          child: Text(
            bluetoothState.message!,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 18
            ),
          ),
        );
  }
}

extension BluetoothStateExt on BluetoothAdapterState{
  String? get message => switch(this){
    BluetoothAdapterState.unavailable => 'Bluetooth is not available for this device',
    BluetoothAdapterState.unauthorized => 'App is denied permission for bluetooth',
    BluetoothAdapterState.off => 'Bluetooth is turned off. Please turn it on or allow it to be turned on.',
    _ => null
  };
}