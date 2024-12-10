part of 'page.dart';

class _CanvasWrapper extends ConsumerWidget{
  const _CanvasWrapper({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final prev = ref.read(prevCanvasSizeProvider);
      final current = ref.read(canvasSizeProvider);

      if(prev != null && current != null && current.width == prev.width) return;

      ref.read(prevCanvasSizeProvider.notifier).state = size;
      ref.read(canvasSizeProvider.notifier).state = size;
    });

    ref.watch(pointsProvider);

    return GestureDetector(
        onVerticalDragUpdate: (details){
          handleDragUpdate(details, context, ref);
        },
        onVerticalDragEnd: (_){
          handleDragEnd(context, ref);
        },
        onPanUpdate: (details) {
          handleDragUpdate(details, context, ref);
        },
        onPanEnd: (_) {
          handleDragEnd(context, ref);
        },
        child: _Canvas(height: size.height, width: size.width)
    );
  }

  handleDragEnd(BuildContext context, WidgetRef ref){
    final notifier = ref.read(pointsProvider.notifier);
    final state = [...notifier.state];
    state.add(null);
    notifier.state = state;
  }

  handleDragUpdate(DragUpdateDetails details, BuildContext context, WidgetRef ref){
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);

    if(
    localPosition.dx < 0 || localPosition.dy < 0
        || localPosition.dx > size.width || localPosition.dy > size.height
    ) return;

    final notifier = ref.read(pointsProvider.notifier);
    final state = [...notifier.state];
    state.add(DrawnPoint(
        localPosition.dx,
        localPosition.dy,
        DateTime.now().millisecondsSinceEpoch
    ));
    notifier.state = state;
  }
}

class _Canvas extends ConsumerWidget{
  const _Canvas({
    required this.width,
    required this.height
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(pointsProvider);

    return SizedBox(
      height: height,
      width: width,
      child: CustomPaint(
        size: Size(height, width),
        painter: PaintCanvas(points: points),
        willChange: true,
      ),
    );
  }
}

class PaintCanvas extends CustomPainter {
  final List<DrawnPoint?> points;

  PaintCanvas({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!.toOffset(), points[i + 1]!.toOffset(), paint);
      }
    }
  }

  @override
  bool shouldRepaint(PaintCanvas oldDelegate) => points.length != oldDelegate.points.length;
}