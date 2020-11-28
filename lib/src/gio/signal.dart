import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';

typedef g_signal_connect_data_func = ffi.Void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<Utf8>,
    ffi.Pointer<ffi.NativeFunction<GSignalCallback>>, ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void> _, ffi.Int32 flags);
typedef GSignalConnectData = void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<Utf8>,
    ffi.Pointer<ffi.NativeFunction<GSignalCallback>>, ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void> _, int flags);

void _gSignalConnectData(
    ffi.Pointer<ffi.Void> application,
    String name,
    ffi.Pointer<ffi.NativeFunction<GSignalCallback>> callback,
    ffi.Pointer<ffi.Void> data,
    ffi.Pointer<ffi.Void> _,
    int flags) {
  final f = gtk.lookupFunction<g_signal_connect_data_func, GSignalConnectData>('g_signal_connect_data');
  f(application, Utf8.toUtf8(name), callback, data, _, flags);
}

typedef GSignalCallback = ffi.Void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>);

void gSignalConnect(ffi.Pointer<ffi.Void> application, String name,
    ffi.Pointer<ffi.NativeFunction<GSignalCallback>> callback, ffi.Pointer<ffi.Void> data) {
  _gSignalConnectData(application, name, callback, data, ffi.nullptr, 0);
}
