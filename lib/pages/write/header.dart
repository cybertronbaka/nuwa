part of 'page.dart';

class _Header extends StatelessWidget{
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NuwaColors.white,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(
            'Data Collection: Using stylus',
            maxLines: 2,
            softWrap: true,
            style: TextStyle(
                fontFamily: 'AllRoundGothic',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: NuwaColors.black
            ),
          )),
          _ConnectionStatus()
        ],
      ),
    );
  }
}