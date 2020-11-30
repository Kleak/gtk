import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';

typedef g_signal_connect_data_func = Void Function(Pointer<Void>, Pointer<Utf8>, Pointer<NativeFunction>, Pointer<Void>,
    Pointer<NativeFunction> destroyData, Int32 flags);
typedef GSignalConnectData = void Function(Pointer<Void>, Pointer<Utf8>, Pointer<NativeFunction>, Pointer<Void>,
    Pointer<NativeFunction> destroyData, int flags);

void _gSignalConnectData(Pointer<Void> application, String name, Pointer<NativeFunction> callback, Pointer<Void> data,
    Pointer<NativeFunction> destroyData, int flags) {
  final f = gtk.lookupFunction<g_signal_connect_data_func, GSignalConnectData>('g_signal_connect_data');
  f(application, Utf8.toUtf8(name), callback, data, destroyData, flags);
}

typedef GCallback = Void Function();
typedef GSignalCallback = Void Function(Pointer<Void>, Pointer<Void>);

void gSignalConnect(Pointer<Void> application, String name, Pointer<NativeFunction> callback, Pointer<Void> data) {
  _gSignalConnectData(application, name, callback, data, nullptr, 0);
}

void gSignalConnectSwapped(
    Pointer<Void> application, String name, Pointer<NativeFunction> callback, Pointer<Void> data) {
  _gSignalConnectData(application, name, callback, data, nullptr, 2);
}
