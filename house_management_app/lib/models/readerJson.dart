import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class InfoRearder {
  Future<String> getInfo() async {
    try {
      final f = await getApplicationCacheDirectory();
      File file = File("${f.path}/account.json");
      if (await file.exists()) {
        String data = await file.readAsString();
        return data;
      } else {
        return "file-not-found";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
