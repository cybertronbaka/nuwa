import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class FileUtils{
  static Future<File> writeFile(Uint8List data, String name) async {
    // storage permission ask
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    // the downloads folder path
    Directory dir = await getApplicationDocumentsDirectory();
    var filePath = '${dir.path}/$name';
    // the data
    var bytes = ByteData.view(data.buffer);
    final buffer = bytes.buffer;
    // save the data in the path
    return File(filePath).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  static void openPdf(String filePath){
    const types = {".pdf": "application/pdf"};
    openOtherTypeFile() async {
      await OpenFile.open(filePath, type: types['.pdf']);
    }
    openOtherTypeFile();
  }
}