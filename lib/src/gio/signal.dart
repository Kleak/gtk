import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';

typedef g_signal_connect_data_func = Void Function(Pointer<Void>, Pointer<Utf8>,
    Pointer<NativeFunction<GSignalCallback>>, Pointer<Void>, Pointer<Void> _, Int32 flags);
typedef GSignalConnectData = void Function(
    Pointer<Void>, Pointer<Utf8>, Pointer<NativeFunction<GSignalCallback>>, Pointer<Void>, Pointer<Void> _, int flags);

void _gSignalConnectData(Pointer<Void> application, String name, Pointer<NativeFunction<GSignalCallback>> callback,
    Pointer<Void> data, Pointer<Void> _, int flags) {
  final f = gtk.lookupFunction<g_signal_connect_data_func, GSignalConnectData>('g_signal_connect_data');
  f(application, Utf8.toUtf8(name), callback, data, _, flags);
}

typedef GSignalCallback = Void Function(Pointer<Void>, Pointer<Void>);

void gSignalConnect(
    Pointer<Void> application, String name, Pointer<NativeFunction<GSignalCallback>> callback, Pointer<Void> data) {
  _gSignalConnectData(application, name, callback, data, nullptr, 0);
}
