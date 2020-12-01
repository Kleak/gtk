import 'dart:ffi';

import 'package:gtk/src/gtk.dart';
import 'package:gtk/src/gtk/widget.dart';

typedef gtk_container_add_func = Pointer<Void> Function(Pointer<Void>, Pointer<Void>);
typedef GtkContainerAdd = Pointer<Void> Function(Pointer<Void>, Pointer<Void>);

Pointer<Void> gtkContainerAdd(Pointer<Void> window, Pointer<Void> child) {
  final f = gtk.lookupFunction<gtk_container_add_func, GtkContainerAdd>('gtk_container_add');
  return f(window, child);
}

class GtkContainer extends GtkWidget {
  GtkContainer.fromNative(Pointer<Void> nativePointer) : super.fromNative(nativePointer);

  void add(GtkWidget widget) {
    gtkContainerAdd(nativePointer, widget.nativePointer);
  }
}
