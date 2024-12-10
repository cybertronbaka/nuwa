part of 'page.dart';

class _CanvasSection extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                  'Please write below',
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
                      Icon(Icons.download, size: 18),
                      SizedBox(width: 6),
                      Text('Export PDF')
                    ],
                  )
              )
            ],
          ),
          smallGap,
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: NuwaColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(),
              ),
            ),
          )
        ],
      ),
    );
  }
}