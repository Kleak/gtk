import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';

class GApplication extends ffi.Struct {}

class GtkApplication extends ffi.Struct {
  ffi.Pointer<GApplication> parent_instance;
}

typedef gtk_application_new_func = ffi.Pointer<ffi.Void> Function(ffi.Pointer<Utf8>, ffi.Int32);
typedef GtkApplicatNew = ffi.Pointer<ffi.Void> Function(ffi.Pointer<Utf8>, int);

ffi.Pointer<ffi.Void> gtkApplicationNew(String applicationId, int flags) {
  final f = gtk.lookupFunction<gtk_application_new_func, GtkApplicatNew>('gtk_application_new');
  return f(Utf8.toUtf8(applicationId), flags);
}
