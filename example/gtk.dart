import 'dart:ffi';

import 'package:gtk/gtk.dart';

void helloWorld(Pointer<Void> widget, Pointer<Void> data) {
  print('Hello world');
}

void activate(Pointer<Void> application, Pointer<Void> userData) {
  final window = gtkApplicationWindowNew(application);
  gtkWindowSetTitle(window, 'Dart GTK example');
  gtkWindowSetDefaultSize(window, 200, 200);

  final button = gtkButtonNewWithLabel('Hello world');
  gSignalConnect(
      button, 'clicked', Pointer.fromFunction<Void Function(Pointer<Void>, Pointer<Void>)>(helloWorld), nullptr);
  gSignalConnectSwapped(button, 'clicked', Pointer.fromFunction<Void Function(Pointer<Void>)>(gtkWindowClose), window);
  gtkContainerAdd(window, button);

  gtkWidgetShowAll(window);
}

int main(List<String> arguments) {
  initGtk();
  final app = gtkApplicationNew('dev.kleak.gtk_example', GApplicationFlags.flagsNone);
  gSignalConnect(app, 'activate', Pointer.fromFunction<Void Function(Pointer<Void>, Pointer<Void>)>(activate), nullptr);

  final status = gApplicationRun(app);
  gObjectUnref(app);
  return status;
}
