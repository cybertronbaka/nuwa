library write_page;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuwa_assignment/app/app.dart';
import 'package:nuwa_assignment/controllers/controllers.dart';
import 'package:nuwa_assignment/misc/gaps.dart';
import 'package:nuwa_assignment/models/models.dart';
import 'package:nuwa_assignment/states/states.dart';
import 'package:nuwa_assignment/widgets/widgets.dart';

part 'canvas.dart';
part 'canvas_section.dart';
part 'header.dart';
part 'connection_status.dart';
part 'text_section.dart';

class WritePage extends ConsumerWidget{
  const WritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(writeControllerProvider);

    controller.init();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: NuwaColors.white,
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            leadingWidth: 0,
            title: _Header()
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _TextSection(),
              _CanvasSection(),
            ]),
          )
        ],
      ),
    );
  }
}

