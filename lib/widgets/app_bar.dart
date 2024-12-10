part of 'widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      automaticallyImplyLeading: false,
      title: Image.asset(
        'assets/images/logo.png',
        height: 48,
        width: 48,
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 32,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
