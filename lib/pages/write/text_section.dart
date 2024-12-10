part of 'page.dart';

class _TextSection extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(writeControllerProvider);
    final text = ref.watch(randomWordProvider);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Text Experiment',
                style: TextStyle(
                  fontFamily: 'AllRoundGothic',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )
              ),
              ElevatedButton(
                onPressed: (){},
                child: const Row(
                  children: [
                    Icon(Icons.refresh_rounded, size: 18),
                    SizedBox(width: 6),
                    Text('Refresh')
                  ],
                )
              )
            ],
          ),
          smallGap,
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: NuwaColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: text == null ? const ConnectingIndicator() : Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'AllRoundGothic',
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  )
              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}