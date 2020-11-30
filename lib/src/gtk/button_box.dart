import 'dart:ffi';

import 'package:gtk/src/gtk.dart';
import 'package:gtk/src/gtk/enums.dart';

typedef gtk_button_box_new_func = Pointer<Void> Function(Int32);
typedef GtkButtonBoxNew = Pointer<Void> Function(int);

Pointer<Void> gtkButtonBoxNew(GtkOrientation orientation) {
  final f = gtk.lookupFunction<gtk_button_box_new_func, GtkButtonBoxNew>('gtk_button_box_new');
  return f(orientation.value);
}
