part of 'controllers.dart';

final connectControllerProvider = Provider((ref) => ConnectController(ref));

class ConnectController{
  ConnectController(this.ref);

  final Ref ref;

  Future<void> connect(BuildContext context){
    final statusNotifier = ref.read(pencilConnectionStatusProvider.notifier);
    statusNotifier.state = PencilConnectionStatus.connecting;
    return ref.read(pencilRepoProvider).connect().then((_){
      print('Connected');
      statusNotifier.state = PencilConnectionStatus.connected;
    }).onError((e, stacktrace){
      print('Failed to connect');
      statusNotifier.state = PencilConnectionStatus.disconnected;
      if(context.mounted){
        CustomSnackBar.showErrorNotification(context, e.toString());
      }
    });
  }

  void navigateToWrite(BuildContext context){
    Navigator.of(context).pushNamed(Routes.write);
  }
}