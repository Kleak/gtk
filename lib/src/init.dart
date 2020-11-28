import 'dart:ffi';

import 'package:gtk/src/gtk.dart';

void initGtk() {
  gtk = DynamicLibrary.open('/usr/lib/x86_64-linux-gnu/libgtk-3.so');
}
