part of 'widgets.dart';

class Footer extends StatelessWidget{
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: const Text(
        'NUWA PEN B.Y',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'AllRoundGothic',
          fontSize: 12,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}