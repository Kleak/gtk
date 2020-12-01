import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:gtk/gtk.dart';
import 'package:gtk/src/gio/enums.dart';
import 'package:gtk/src/gtk.dart';

class NativeGtkApplication extends Struct {}

typedef gtk_application_new_func = Pointer<NativeGtkApplication> Function(Pointer<Utf8>, Int32);
typedef GtkApplicatNew = Pointer<NativeGtkApplication> Function(Pointer<Utf8>, int);

Pointer<NativeGtkApplication> gtkApplicationNew(String applicationId, GApplicationFlags flags) {
  final f = gtk.lookupFunction<gtk_application_new_func, GtkApplicatNew>('gtk_application_new');
  return f(Utf8.toUtf8(applicationId), flags.value);
}

class GtkApplicationEvent {
  final GtkApplication application;
  final Pointer<Void> userData;

  const GtkApplicationEvent(this.application, this.userData);
}

final _gtkApplicationOnActivateController = StreamController<GtkApplicationEvent>(sync: true);

void _onGtkApplicationActivate(Pointer<NativeGtkApplication> application, Pointer<Void> userData) {
  _gtkApplicationOnActivateController.add(GtkApplicationEvent(GtkApplication.fromNative(application), userData));
}

class GtkApplication {
  final Pointer<NativeGtkApplication> nativePointer;

  GtkApplication.fromNative(this.nativePointer);

  GtkApplication(String applicationId)
      : nativePointer = gtkApplicationNew(applicationId, GApplicationFlags.flagsNone).cast() {
    gSignalConnect(
      nativePointer.cast(),
      'activate',
      Pointer.fromFunction<Void Function(Pointer<NativeGtkApplication>, Pointer<Void>)>(_onGtkApplicationActivate),
      nullptr,
    );
  }

  Stream<GtkApplicationEvent> get onActivate => _gtkApplicationOnActivateController.stream
      .where((event) => event.application.nativePointer.address == nativePointer.address);

  int run() => gApplicationRun(nativePointer.cast());

  void destroy() => gObjectUnref(nativePointer.cast());
}
