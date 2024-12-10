part of 'widgets.dart';

class ConnectingIndicator extends StatefulWidget{
  const ConnectingIndicator({super.key});

  @override
  State<StatefulWidget> createState() => ConnectingIndicatorState();
}

const _lightColor = Color(0x4D6682E5);
const _darkColor = Color(0xFF6682E5);

class ConnectingIndicatorState extends State<ConnectingIndicator>{
  int _index = -1;
  late Timer _timer;
  final int _circlesCount = 3;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _index = (_index + 1) % (_circlesCount + 1);
        if(_index == _circlesCount) _index = -1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_circlesCount, (i){
        return Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: i <= _index ? _darkColor : _lightColor,
                shape: BoxShape.circle,
              ),
            ),
            if(i != _circlesCount - 1) const SizedBox(width: 4.0)
          ],
        );
      }),
    );
  }
}