import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';

typedef gtk_application_window_new_func = ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>);
typedef GtkApplicationWindowNew = ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>);

ffi.Pointer<ffi.Void> gtkApplicationWindowNew(ffi.Pointer<ffi.Void> application) {
  final f = gtk.lookupFunction<gtk_application_window_new_func, GtkApplicationWindowNew>('gtk_application_window_new');
  return f(application);
}

typedef gtk_window_set_title_func = ffi.Void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<Utf8>);
typedef GtkWindowSetTitle = void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<Utf8>);

void gtkWindowSetTitle(ffi.Pointer<void> window, String title) {
  final f = gtk.lookupFunction<gtk_window_set_title_func, GtkWindowSetTitle>('gtk_application_window_new');
  f(window, Utf8.toUtf8(title));
}

typedef gtk_window_set_default_size_func = ffi.Void Function(ffi.Pointer<ffi.Void>, ffi.Int32, ffi.Int32);
typedef GtkWindowSetDefaultSize = void Function(ffi.Pointer<ffi.Void>, int, int);

void gtkWindowSetDefaultSize(ffi.Pointer<void> window, int width, int height) {
  final f =
      gtk.lookupFunction<gtk_window_set_default_size_func, GtkWindowSetDefaultSize>('gtk_window_set_default_size');
  f(window, width, height);
}

typedef gtk_window_show_all_func = ffi.Void Function(ffi.Pointer<ffi.Void>);
typedef GtkWindowShowAll = void Function(ffi.Pointer<ffi.Void>);

void gtkWindowShowAll(ffi.Pointer<void> window) {
  final f = gtk.lookupFunction<gtk_window_show_all_func, GtkWindowShowAll>('gtk_window_show_all');
  f(window);
}
