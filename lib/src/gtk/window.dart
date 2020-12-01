import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';
import 'package:gtk/src/gtk/bin.dart';

class NativeGtkWindow extends Struct {}

typedef gtk_window_set_title_func = Void Function(Pointer<Void>, Pointer<Utf8>);
typedef GtkWindowSetTitle = void Function(Pointer<Void>, Pointer<Utf8>);

void gtkWindowSetTitle(Pointer<Void> window, String title) {
  final f = gtk.lookupFunction<gtk_window_set_title_func, GtkWindowSetTitle>('gtk_window_set_title');
  f(window, Utf8.toUtf8(title));
}

typedef gtk_window_set_default_size_func = Void Function(Pointer<Void>, Int32, Int32);
typedef GtkWindowSetDefaultSize = void Function(Pointer<Void>, int, int);

void gtkWindowSetDefaultSize(Pointer<Void> window, int width, int height) {
  final f =
      gtk.lookupFunction<gtk_window_set_default_size_func, GtkWindowSetDefaultSize>('gtk_window_set_default_size');
  f(window, width, height);
}

typedef gtk_window_close_func = Void Function(Pointer<Void>);
typedef GtkWindowClose = void Function(Pointer<Void>);

void gtkWindowClose(Pointer<Void> window) {
  final f = gtk.lookupFunction<gtk_window_close_func, GtkWindowClose>('gtk_window_close');
  f(window);
}

class Size {
  final int width;
  final int height;

  const Size(this.width, this.height);
}

class GtkWindow extends GtkBin {
  GtkWindow.fromNative(Pointer<Void> nativePointer) : super.fromNative(nativePointer);

  set title(String newTitle) {
    gtkWindowSetTitle(nativePointer.cast(), newTitle);
  }

  set defaultSize(Size size) {
    gtkWindowSetDefaultSize(nativePointer.cast(), size.width, size.height);
  }
}
