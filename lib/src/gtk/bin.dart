import 'dart:ffi';

import 'package:gtk/src/gtk/container.dart';

class GtkBin extends GtkContainer {
  GtkBin.fromNative(Pointer<Void> nativePointer) : super.fromNative(nativePointer);
}
