import 'dart:ffi';

import 'package:gtk/src/gtk.dart';

void initGtk({String path = '/usr/lib/x86_64-linux-gnu/libgtk-3.so'}) {
  gtk = DynamicLibrary.open(path);
}
