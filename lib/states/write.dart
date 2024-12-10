part of 'states.dart';

final randomWordProvider = StateProvider.autoDispose<String?>((ref) => null);

final canvasSizeProvider = StateProvider.autoDispose<Size?>(
    (ref) => null);
final prevCanvasSizeProvider = StateProvider.autoDispose<Size?>(
        (ref) => null);
final pointsProvider = StateProvider<List<DrawnPoint?>>((ref) => []);
