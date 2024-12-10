part of 'page.dart';

class _EntryCard extends StatelessWidget{
  const _EntryCard();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12)
            ),
            child: Image.asset(
              'assets/images/entry/entry_1.png',
              fit: BoxFit.contain,
            ),
          ),
          mediumGap,
          const Text(
            'Data Collection and Testing Tool',
            style: TextStyle(
              fontFamily: 'AllRoundGothic',
              fontSize: 32,
              fontWeight: FontWeight.w600
            ),
          ),
          mediumGap,
          FilledButton(
            onPressed: (){
              Navigator.of(context).pushNamed(Routes.connect);
            },
            child: const Text('Data Collection')
          )
        ],
      ),
    );
  }
}