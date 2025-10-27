import 'dart:developer';
import 'package:flutter/foundation.dart';

///* Print shortcuts `print()`
void uniPrint(dynamic data) {
  if (kDebugMode) {
    print(data);
  }
}

///* Print in log shortcuts `log()`
void uniLog(dynamic data) {
  if (kDebugMode) {
    log(data.toString(), time: DateTime.now());
  }
}
