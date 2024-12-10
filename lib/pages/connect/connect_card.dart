part of 'page.dart';

class _ConnectCard extends StatelessWidget{
  const _ConnectCard();

  @override
  Widget build(BuildContext context) {
    return const CustomCard(child: _ConnectionContent());
  }
}

class _ConnectionContent extends ConsumerWidget{
  const _ConnectionContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionStatus = ref.watch(pencilConnectionStatusProvider);
    final action = connectionStatus.action;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
              color: connectionStatus.iconBgColor,
              borderRadius: BorderRadius.circular(5000)
          ),
          child: connectionStatus.icon(),
        ),
        mediumGap,
        Column(
          children: [
            Text(
              connectionStatus.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'AllRoundGothic',
                  fontWeight: FontWeight.w600,
                  fontSize: 32
              ),
            ),
            smallGap,
            Text(
              connectionStatus.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
        mediumGap,
        FilledButton(
          onPressed: action != null ? () => action(context, ref) : null,
          child: Text(connectionStatus.btnLabel)
        )
      ],
    );
  }
}


extension PencilConnectionStatusExt on PencilConnectionStatus{
  String get title => switch(this){
    PencilConnectionStatus.disconnected => 'Stylus is not connected',
    PencilConnectionStatus.connecting => 'Connecting...',
    PencilConnectionStatus.connected => 'Connected'
  };

  String get subtitle => switch(this){
    PencilConnectionStatus.disconnected => 'Please connect your stylus\nto start data collection',
    PencilConnectionStatus.connecting => 'Please wait for your stylus\nto be connected.',
    PencilConnectionStatus.connected => 'Your stylus is connected.\nYou can start data collection.'
  };

  Widget icon() => switch(this){
    PencilConnectionStatus.disconnected => const Icon(CupertinoIcons.pen, size: 32,),
    PencilConnectionStatus.connecting => Container(),
    PencilConnectionStatus.connected => const Icon(CupertinoIcons.pen, size: 32, color: NuwaColors.primary)
  };

  Color get iconBgColor => switch(this){
    PencilConnectionStatus.connected => NuwaColors.lightGreen,
    _ => NuwaColors.grey,
  };

  String get btnLabel => switch(this){
    PencilConnectionStatus.disconnected => 'Connect Stylus',
    _ => 'Start'
  };

  void Function(BuildContext context, WidgetRef ref)? get action => switch(this){
    PencilConnectionStatus.disconnected => (context, ref) => ref.read(connectControllerProvider).connect(context),
    _ => (context, ref) => ref.read(connectControllerProvider).navigateToWrite(context)
  };
}