import 'dart:ffi';

import 'package:gtk/gtk.dart';

void helloWorld(Pointer<Void> widget, Pointer<Void> data) {
  print('Hello world');
}

void activate(Pointer<NativeGtkApplication> application, Pointer<Void> userData) {
  final window = gtkApplicationWindowNew(application);
  gtkWindowSetTitle(window.cast(), 'Dart GTK example');
  gtkWindowSetDefaultSize(window.cast(), 200, 200);

  final button = gtkButtonNewWithLabel('Hello world');
  gSignalConnect(
      button, 'clicked', Pointer.fromFunction<Void Function(Pointer<Void>, Pointer<Void>)>(helloWorld), nullptr);
  gSignalConnectSwapped(
      button, 'clicked', Pointer.fromFunction<Void Function(Pointer<Void>)>(gtkWindowClose), window.cast());
  gtkContainerAdd(window.cast(), button);

  gtkWidgetShowAll(window.cast());
}

int main(List<String> arguments) {
  initGtk();
  final app = gtkApplicationNew('dev.kleak.gtk_example', GApplicationFlags.flagsNone);
  gSignalConnect(app.cast(), 'activate',
      Pointer.fromFunction<Void Function(Pointer<NativeGtkApplication>, Pointer<Void>)>(activate), nullptr);

  final status = gApplicationRun(app.cast());
  gObjectUnref(app.cast());
  return status;
}
