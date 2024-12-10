library nuwa_assignment_app;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuwa_assignment/pages/connect/page.dart';
import 'package:nuwa_assignment/pages/entry/page.dart';
import 'package:nuwa_assignment/pages/write/page.dart';

part 'router.dart';
part 'routes.dart';
part 'color.dart';
part 'theme.dart';

/// [NuwaAssignmentApp] contains [MaterialApp] and
/// the global [ProviderScope] required by riverpod.
class NuwaAssignmentApp extends StatelessWidget{
  const NuwaAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        scrollBehavior:  ScrollConfiguration.of(context).copyWith(
          physics: const BouncingScrollPhysics(),
        ),
        title: 'Nuwa Assignment',
        debugShowCheckedModeBanner: false,
        theme: NuwaTheme.data,
        routes: router,
      ),
    );
  }
}