import 'dart:ffi' as ffi;
import 'package:gtk/src/gtk.dart';
import 'package:gtk/src/gtk/application.dart';

typedef g_object_unref_func = ffi.Void Function(ffi.Pointer<GtkApplication>);
typedef GObjectUnref = void Function(ffi.Pointer<GtkApplication>);

void gObjectUnref(ffi.Pointer<GtkApplication> application) {
  final f = gtk.lookupFunction<g_object_unref_func, GObjectUnref>('g_object_unref');
  f(application);
}
