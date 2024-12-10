library connect_page;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuwa_assignment/app/app.dart';
import 'package:nuwa_assignment/controllers/controllers.dart';
import 'package:nuwa_assignment/misc/gaps.dart';
import 'package:nuwa_assignment/models/models.dart';
import 'package:nuwa_assignment/states/states.dart';
import 'package:nuwa_assignment/widgets/widgets.dart';

part 'connect_card.dart';
part 'connection_status.dart';

class ConnectPage extends ConsumerWidget{
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(connectControllerProvider);
    
    controller.init();

    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ConnectionStatus(),
              _ConnectCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}