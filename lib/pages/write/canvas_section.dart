part of 'page.dart';

class _CanvasSection extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(writeControllerProvider);
    ref.watch(canvasSizeProvider);
    ref.watch(prevCanvasSizeProvider);

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
                  onPressed: (){
                    controller.exportPdf(context);
                  },
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
            child: LayoutBuilder(
              builder: (_, constraints){
                return _CanvasWrapper(
                  size: Size(constraints.maxWidth, 300),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}