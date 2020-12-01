import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:gtk/gtk.dart';
import 'package:gtk/src/gtk.dart';

class NativeGtkHeaderBar extends Struct {}

typedef gtk_header_bar_new_func = Pointer<NativeGtkHeaderBar> Function();
typedef GtkHeaderBarNew = Pointer<NativeGtkHeaderBar> Function();

Pointer<NativeGtkHeaderBar> gtkHeaderBarNew() {
  final f = gtk.lookupFunction<gtk_header_bar_new_func, GtkHeaderBarNew>('gtk_header_bar_new');
  return f();
}

typedef gtk_header_bar_set_title_func = Void Function(Pointer<NativeGtkHeaderBar>, Pointer<Utf8>);
typedef GtkHeaderBarSetTitle = void Function(Pointer<NativeGtkHeaderBar>, Pointer<Utf8>);

void gtkHeaderBarSetTitle(Pointer<NativeGtkHeaderBar> headerBar, Pointer<Utf8> title) {
  final f = gtk.lookupFunction<gtk_header_bar_set_title_func, GtkHeaderBarSetTitle>('gtk_header_bar_set_title');
  f(headerBar, title);
}

typedef gtk_header_bar_set_show_close_button_func = Void Function(Pointer<NativeGtkHeaderBar>, Int8);
typedef GtkHeaderBarSetShowCloseButton = void Function(Pointer<NativeGtkHeaderBar>, int);

void gtkHeaderBarSetShowCloseButton(Pointer<NativeGtkHeaderBar> headerBar, int show) {
  final f = gtk.lookupFunction<gtk_header_bar_set_show_close_button_func, GtkHeaderBarSetShowCloseButton>(
      'gtk_header_bar_set_show_close_button');
  f(headerBar, show);
}

class GtkHeaderBar extends GtkContainer {
  GtkHeaderBar.fromNative(Pointer<NativeGtkHeaderBar> nativePointer) : super.fromNative(nativePointer.cast());

  GtkHeaderBar() : super.fromNative(gtkHeaderBarNew().cast());

  set title(String newTitle) {
    gtkHeaderBarSetTitle(nativePointer.cast(), Utf8.toUtf8(newTitle));
  }

  set showCloseButton(bool newValue) {
    gtkHeaderBarSetShowCloseButton(nativePointer.cast(), newValue ? 1 : 0);
  }
}
