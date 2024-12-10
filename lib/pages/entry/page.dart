library entry_page;

import 'package:flutter/material.dart';
import 'package:nuwa_assignment/app/app.dart';
import 'package:nuwa_assignment/misc/gaps.dart';
import 'package:nuwa_assignment/widgets/widgets.dart';

part 'entry_card.dart';

class EntryPage extends StatelessWidget{
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: _EntryCard(),
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}