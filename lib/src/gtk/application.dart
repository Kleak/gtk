import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';

class GApplication extends Struct {}

class GtkApplication extends Struct {
  Pointer<GApplication> parent_instance;
}

typedef gtk_application_new_func = Pointer<Void> Function(Pointer<Utf8>, Int32);
typedef GtkApplicatNew = Pointer<Void> Function(Pointer<Utf8>, int);

Pointer<Void> gtkApplicationNew(String applicationId, int flags) {
  final f = gtk.lookupFunction<gtk_application_new_func, GtkApplicatNew>('gtk_application_new');
  return f(Utf8.toUtf8(applicationId), flags);
}
