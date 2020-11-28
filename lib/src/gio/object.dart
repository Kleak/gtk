import 'dart:ffi' as ffi;
import 'package:gtk/src/gtk.dart';

typedef g_object_unref_func = ffi.Void Function(ffi.Pointer<ffi.Void>);
typedef GObjectUnref = void Function(ffi.Pointer<ffi.Void>);

void gObjectUnref(ffi.Pointer<ffi.Void> application) {
  final f = gtk.lookupFunction<g_object_unref_func, GObjectUnref>('g_object_unref');
  f(application);
}
