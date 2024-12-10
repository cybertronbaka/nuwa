library controllers;

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuwa_assignment/app/app.dart';
import 'package:nuwa_assignment/models/models.dart';
import 'package:nuwa_assignment/repositories/pencil_repository/pencil_repository.dart';
import 'package:nuwa_assignment/states/states.dart';
import 'package:nuwa_assignment/utils/snackbar.dart';
import 'package:nuwa_assignment/utils/word_geneartor.dart';

part 'connect_controller.dart';
part 'write_controller.dart';