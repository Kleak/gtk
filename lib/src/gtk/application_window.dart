import 'dart:ffi';

import 'package:gtk/src/gtk.dart';
import 'package:gtk/src/gtk/application.dart';
import 'package:gtk/src/gtk/window.dart';

class NativeGtkApplicationWindow extends Struct {}

typedef gtk_application_window_new_func = Pointer<Void> Function(Pointer<Void>);
typedef GtkApplicationWindowNew = Pointer<Void> Function(Pointer<Void>);

Pointer<Void> gtkApplicationWindowNew(Pointer<Void> application) {
  final f = gtk.lookupFunction<gtk_application_window_new_func, GtkApplicationWindowNew>('gtk_application_window_new');
  return f(application);
}

class GtkApplicationWindow extends GtkWindow {
  GtkApplicationWindow.fromNative(Pointer<Void> nativePointer) : super.fromNative(nativePointer);

  GtkApplicationWindow.fromGtkApplication(GtkApplication application)
      : super.fromNative(gtkApplicationWindowNew(application.nativePointer));
}
