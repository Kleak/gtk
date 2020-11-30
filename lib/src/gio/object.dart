import 'dart:ffi';
import 'package:gtk/src/gtk.dart';

typedef g_object_unref_func = Void Function(Pointer<Void>);
typedef GObjectUnref = void Function(Pointer<Void>);

void gObjectUnref(Pointer<Void> application) {
  final f = gtk.lookupFunction<g_object_unref_func, GObjectUnref>('g_object_unref');
  f(application);
}
