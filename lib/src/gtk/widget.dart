import 'dart:ffi';

import 'package:gtk/src/gtk.dart';

class NativeGtkWidget extends Struct {}

typedef gtk_widget_show_all_func = Void Function(Pointer<NativeGtkWidget>);
typedef GtkWidgetShowAll = void Function(Pointer<NativeGtkWidget>);

void gtkWidgetShowAll(Pointer<NativeGtkWidget> window) {
  final f = gtk.lookupFunction<gtk_widget_show_all_func, GtkWidgetShowAll>('gtk_widget_show_all');
  f(window);
}

class GtkWidget {
  final Pointer<NativeGtkWidget> nativePointer;

  GtkWidget.fromNative(this.nativePointer);

  void show() {
    gtkWidgetShowAll(nativePointer);
  }
}
