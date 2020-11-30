import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';

typedef gtk_application_window_new_func = Pointer<Void> Function(Pointer<Void>);
typedef GtkApplicationWindowNew = Pointer<Void> Function(Pointer<Void>);

Pointer<Void> gtkApplicationWindowNew(Pointer<Void> application) {
  final f = gtk.lookupFunction<gtk_application_window_new_func, GtkApplicationWindowNew>('gtk_application_window_new');
  return f(application);
}

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
