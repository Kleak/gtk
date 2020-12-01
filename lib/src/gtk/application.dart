import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:gtk/gtk.dart';
import 'package:gtk/src/gio/enums.dart';
import 'package:gtk/src/gtk.dart';

class NativeGtkApplication extends Struct {}

typedef gtk_application_new_func = Pointer<Void> Function(Pointer<Utf8>, Int32);
typedef GtkApplicatNew = Pointer<Void> Function(Pointer<Utf8>, int);

Pointer<Void> gtkApplicationNew(String applicationId, GApplicationFlags flags) {
  final f = gtk.lookupFunction<gtk_application_new_func, GtkApplicatNew>('gtk_application_new');
  return f(Utf8.toUtf8(applicationId), flags.value);
}

class GtkApplicationActivateEvent {
  final Pointer<Void> application;
  final Pointer<Void> userData;

  const GtkApplicationActivateEvent(this.application, this.userData);
}

final _gtkApplicationOnActivateController = StreamController<GtkApplicationActivateEvent>();

void _onGtkApplicationOnActivate(Pointer<Void> application, Pointer<Void> userData) {
  final app = GtkApplication.fromNative(application);

  final appWin = GtkApplicationWindow.fromGtkApplication(app);
  appWin.show();

  _gtkApplicationOnActivateController.add(GtkApplicationActivateEvent(application, userData));
}

class GtkApplication {
  final Pointer<Void> nativePointer;

  GtkApplication.fromNative(this.nativePointer);

  GtkApplication(String applicationId) : nativePointer = gtkApplicationNew(applicationId, GApplicationFlags.flagsNone) {
    gSignalConnect(
      nativePointer,
      'activate',
      Pointer.fromFunction<Void Function(Pointer<Void>, Pointer<Void>)>(_onGtkApplicationOnActivate),
      nullptr,
    );
  }

  Stream<GtkApplicationActivateEvent> get onActivate =>
      _gtkApplicationOnActivateController.stream.where((event) => event.application.address == nativePointer.address);

  int run() => gApplicationRun(nativePointer);

  void destroy() => gObjectUnref(nativePointer);
}
