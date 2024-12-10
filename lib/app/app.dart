library nuwa_assignment_app;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuwa_assignment/pages/entry/page.dart';

part 'router.dart';
part 'routes.dart';

class NuwaAssignmentApp extends StatelessWidget{
  const NuwaAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Nuwa Assignment',
        theme: ThemeData(
          primaryColor: const Color(0xFF98CA88),
          useMaterial3: false,
        ),
        home: const EntryPage()
      ),
    );
  }
}