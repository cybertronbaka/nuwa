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
    ref.read(randomWordProvider.notifier).state = WordGenerator.generate();
  }

  Future<void> exportPdf() async {

  }

  void reset(){
    _generateRandomWord();
    _clearCanvas();
  }
}
