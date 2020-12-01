import 'dart:ffi';

import 'package:gtk/src/gtk.dart';
import 'package:gtk/src/gtk/widget.dart';

class NativeGtkContainer extends Struct {}

typedef gtk_container_add_func = Pointer<Void> Function(Pointer<NativeGtkWidget>, Pointer<NativeGtkWidget>);
typedef GtkContainerAdd = Pointer<Void> Function(Pointer<NativeGtkWidget>, Pointer<NativeGtkWidget>);

Pointer<Void> gtkContainerAdd(Pointer<NativeGtkWidget> window, Pointer<NativeGtkWidget> child) {
  final f = gtk.lookupFunction<gtk_container_add_func, GtkContainerAdd>('gtk_container_add');
  return f(window, child);
}

class GtkContainer extends GtkWidget {
  GtkContainer.fromNative(Pointer<NativeGtkContainer> nativePointer) : super.fromNative(nativePointer.cast());

  void add(GtkWidget widget) {
    gtkContainerAdd(nativePointer, widget.nativePointer);
  }
}
