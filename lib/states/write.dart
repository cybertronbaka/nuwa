part of 'states.dart';

final randomWordProvider = StateProvider<String?>((ref) => null);

final canvasSizeProvider = StateProvider<Size?>(
    (ref) => null);
final prevCanvasSizeProvider = StateProvider<Size?>(
        (ref) => null);
final pointsProvider = StateProvider<List<DrawnPoint?>>((ref) => []);
