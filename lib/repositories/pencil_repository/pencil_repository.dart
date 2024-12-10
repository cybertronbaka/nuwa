library pencil_repository;

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuwa_assignment/errors/errors.dart';
import 'package:permission_handler/permission_handler.dart';

part 'bluetooth_pencil_repository.dart';

part 'fake_pencil_repository.dart';

final pencilRepoProvider = StateProvider<PencilRepository>(
    (ref) => throw 'pencilRepoProvider not initialized');

abstract class PencilRepository {
  /// Get the bluetooth adapter state
  Future<Stream<BluetoothAdapterState>> state();
  /// Connect with the device
  Future<void> connect();
}
