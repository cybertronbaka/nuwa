part of 'page.dart';

class _ConnectionStatus extends ConsumerWidget{
  const _ConnectionStatus();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(pencilConnectionStatusProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: status.bgColor,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.pen, size: 24, color: status.fgColor),
          const SizedBox(width: 6.0),
          Text(
            status.label,
            style: TextStyle(
              fontSize: 16,
              color: status.fgColor,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

extension _ConnectionStatusExt on PencilConnectionStatus{
  String get label => switch(this){
    PencilConnectionStatus.connected => 'Connected',
    PencilConnectionStatus.disconnected => 'Disconnected',
    PencilConnectionStatus.connecting => 'Connecting',
  };

  Color get bgColor => switch(this){
    PencilConnectionStatus.connected => NuwaColors.lightGreen,
    PencilConnectionStatus.disconnected => NuwaColors.error,
    PencilConnectionStatus.connecting => NuwaColors.lightGreen,
  };

  Color get fgColor => switch(this){
    PencilConnectionStatus.connected => NuwaColors.primary,
    PencilConnectionStatus.disconnected => NuwaColors.black,
    PencilConnectionStatus.connecting => NuwaColors.primary,
  };
}