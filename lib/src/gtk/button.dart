import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';

typedef gtk_button_new_with_label_func = Pointer<Void> Function(Pointer<Utf8>);
typedef GtkButtonNewWithLabel = Pointer<Void> Function(Pointer<Utf8>);

Pointer<Void> gtkButtonNewWithLabel(String label) {
  final f = gtk.lookupFunction<gtk_button_new_with_label_func, GtkButtonNewWithLabel>('gtk_button_new_with_label');
  return f(Utf8.toUtf8(label));
}
