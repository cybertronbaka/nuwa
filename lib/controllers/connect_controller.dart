part of 'controllers.dart';

final connectControllerProvider = Provider((ref) => ConnectController(ref));

class ConnectController{
  ConnectController(this.ref);

  final Ref ref;

  Future<void> connect(BuildContext context){
    final statusNotifier = ref.read(pencilConnectionStatusProvider.notifier);
    statusNotifier.state = PencilConnectionStatus.connecting;
    return ref.read(pencilRepoProvider).connect().then((_){
      debugPrint('Connected');
      statusNotifier.state = PencilConnectionStatus.connected;
    }).onError((e, stacktrace){
      debugPrint('Failed to connect');
      statusNotifier.state = PencilConnectionStatus.disconnected;
      if(context.mounted){
        CustomSnackBar.showErrorNotification(context, e.toString());
      }
    });
  }

  void navigateToWrite(BuildContext context){
    Navigator.of(context).pushNamed(Routes.write);
  }

  void init(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final state = await ref.read(pencilRepoProvider).state();
      state.listen((data){
        ref.read(bluetoothStateProvider.notifier).state = data;
        if(data.pencilStatus != null){
          ref.read(pencilConnectionStatusProvider.notifier).state = data.pencilStatus!;
        }
      });
    });
  }
}


extension _BluetoothStateToPencilStatusExt on BluetoothAdapterState{
  PencilConnectionStatus? get pencilStatus => switch(this){
    BluetoothAdapterState.unavailable => PencilConnectionStatus.disconnected,
    BluetoothAdapterState.unauthorized => PencilConnectionStatus.disconnected,
    BluetoothAdapterState.off => PencilConnectionStatus.disconnected,
    _ => null
  };
}