part of 'controllers.dart';

final writeControllerProvider = Provider((ref) => WriteController(ref));

class WriteController{
  WriteController(this.ref);

  final Ref ref;

  void init(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateRandomWord();
    });
  }

  void _generateRandomWord(){
    ref.read(randomWordProvider.notifier).state = WordGenerator.generate();
  }

  void _clearCanvas(){
    ref.read(pointsProvider.notifier).state = [];
  }

  Future<void> exportPdf(BuildContext context) async {
    final now = DateTime.now();
    final canvasSize = ref.read(canvasSizeProvider)!;
    final points = ref.read(pointsProvider);

    final pdf = PdfGenerator.generate(canvasSize, points);
    final fileName = '${now.day}-${now.month}-${now.year} ${now.hour}-${now.minute}-${now.second}.pdf';
    return ref.read(fileUtilsProvider)
        .writeFile(await pdf.save(), fileName)
        .then((file){
          debugPrint('File exported to $file');
          if(context.mounted){
            CustomSnackBar.showSuccessNotification(context, 'File downloaded to ${file.path}');
          }
          ref.read(fileUtilsProvider).openPdf(file.path);
        }).onError((e, stackTrace){
          debugPrint(stackTrace.toString());
          if(context.mounted){
            CustomSnackBar.showErrorNotification(context, e.toString());
          }
        });
  }

  void reset(){
    _generateRandomWord();
    _clearCanvas();
  }
}
