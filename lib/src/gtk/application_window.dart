import 'dart:ffi';

import 'package:gtk/src/gtk.dart';
import 'package:gtk/src/gtk/application.dart';
import 'package:gtk/src/gtk/window.dart';

class NativeGtkApplicationWindow extends Struct {}

typedef gtk_application_window_new_func = Pointer<NativeGtkApplicationWindow> Function(Pointer<NativeGtkApplication>);
typedef GtkApplicationWindowNew = Pointer<NativeGtkApplicationWindow> Function(Pointer<NativeGtkApplication>);

Pointer<NativeGtkApplicationWindow> gtkApplicationWindowNew(Pointer<NativeGtkApplication> application) {
  final f = gtk.lookupFunction<gtk_application_window_new_func, GtkApplicationWindowNew>('gtk_application_window_new');
  return f(application);
}

class GtkApplicationWindow extends GtkWindow {
  GtkApplicationWindow.fromNative(Pointer<NativeGtkApplicationWindow> nativePointer)
      : super.fromNative(nativePointer.cast());

  GtkApplicationWindow.fromGtkApplication(GtkApplication application)
      : super.fromNative(gtkApplicationWindowNew(application.nativePointer.cast()).cast());
}
