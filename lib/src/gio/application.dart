import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:gtk/src/gtk.dart';

typedef g_application_run_func = Int32 Function(Pointer<Void>, Int32, Pointer<Pointer<Utf8>>);
typedef GApplicatRun = int Function(Pointer<Void>, int, Pointer<Pointer<Utf8>>);

int gApplicationRun(Pointer<Void> application) {
  final f = gtk.lookupFunction<g_application_run_func, GApplicatRun>('g_application_run');
  return f(application.cast<Void>(), 0, nullptr);
}
