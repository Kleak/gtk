import 'dart:ffi';

import 'package:gtk/src/gtk/container.dart';

class NativeGtkBin extends Struct {}

class GtkBin extends GtkContainer {
  GtkBin.fromNative(Pointer<NativeGtkBin> nativePointer) : super.fromNative(nativePointer.cast());
}
