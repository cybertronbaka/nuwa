part of 'app.dart';

/// [router] contains how to render pages.
/// This can be swapped to dynamic routes and such.
/// Or can be swapped with a router like GoRouter
final Map<String, Widget Function(BuildContext)> router = {
  Routes.entry: (context) => const EntryPage(),
  Routes.connect: (context) => const ConnectPage(),
  Routes.write: (context) => const WritePage(),
};