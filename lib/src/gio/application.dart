import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';

typedef g_application_run_func = ffi.Int32 Function(ffi.Pointer<ffi.Void>, ffi.Int32, ffi.Pointer<ffi.Pointer<Utf8>>);
typedef GApplicatRun = int Function(ffi.Pointer<ffi.Void>, int, ffi.Pointer<ffi.Pointer<Utf8>>);

int gApplicationRun(ffi.Pointer<ffi.Void> application) {
  final f = gtk.lookupFunction<g_application_run_func, GApplicatRun>('g_application_run');
  return f(application.cast<ffi.Void>(), 0, ffi.nullptr);
}
