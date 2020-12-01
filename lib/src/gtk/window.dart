import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:gtk/src/gio/signal.dart';
import 'package:gtk/src/gtk.dart';
import 'package:gtk/src/gtk/bin.dart';
import 'package:gtk/src/gtk/widget.dart';

class NativeGtkWindow extends Struct {}

typedef gtk_window_set_title_func = Void Function(Pointer<NativeGtkWindow>, Pointer<Utf8>);
typedef GtkWindowSetTitle = void Function(Pointer<NativeGtkWindow>, Pointer<Utf8>);

void gtkWindowSetTitle(Pointer<NativeGtkWindow> window, String title) {
  final f = gtk.lookupFunction<gtk_window_set_title_func, GtkWindowSetTitle>('gtk_window_set_title');
  f(window, Utf8.toUtf8(title));
}

typedef gtk_window_set_default_size_func = Void Function(Pointer<NativeGtkWindow>, Int32, Int32);
typedef GtkWindowSetDefaultSize = void Function(Pointer<NativeGtkWindow>, int, int);

void gtkWindowSetDefaultSize(Pointer<NativeGtkWindow> window, int width, int height) {
  final f =
      gtk.lookupFunction<gtk_window_set_default_size_func, GtkWindowSetDefaultSize>('gtk_window_set_default_size');
  f(window, width, height);
}

typedef gtk_window_close_func = Void Function(Pointer<Void>);
typedef GtkWindowClose = void Function(Pointer<Void>);

void gtkWindowClose(Pointer<Void> window) {
  final f = gtk.lookupFunction<gtk_window_close_func, GtkWindowClose>('gtk_window_close');
  f(window);
}

typedef gtk_window_set_titlebar_func = Void Function(Pointer<NativeGtkWindow>, Pointer<NativeGtkWidget>);
typedef GtkWindowSetTitlebar = void Function(Pointer<NativeGtkWindow>, Pointer<NativeGtkWidget>);

void gtkWindowSetTitlebar(Pointer<NativeGtkWindow> window, Pointer<NativeGtkWidget> widget) {
  final f = gtk.lookupFunction<gtk_window_set_titlebar_func, GtkWindowSetTitlebar>('gtk_window_set_titlebar');
  f(window, widget);
}

class Size {
  final int width;
  final int height;

  const Size(this.width, this.height);
}

class GtkWindowEvent {
  final GtkWindow window;
  final Pointer<Void> data;

  const GtkWindowEvent(this.window, this.data);
}

final _gtkWindowOnDestroyController = StreamController<GtkWindowEvent>(sync: true);

void _onGtkWindowDestroy(Pointer<NativeGtkWindow> application, Pointer<Void> userData) {
  _gtkWindowOnDestroyController.add(GtkWindowEvent(GtkWindow.fromNative(application), userData));
}

class GtkWindow extends GtkBin {
  GtkWindow.fromNative(Pointer<NativeGtkWindow> nativePointer) : super.fromNative(nativePointer.cast()) {
    gSignalConnect(
      nativePointer.cast(),
      'destroy',
      Pointer.fromFunction<Void Function(Pointer<NativeGtkWindow>, Pointer<Void>)>(_onGtkWindowDestroy),
      nullptr,
    );
  }

  Stream<GtkWindowEvent> get onDestroy => _gtkWindowOnDestroyController.stream
      .where((event) => event.window.nativePointer.address == nativePointer.address);

  set titleBar(GtkWidget widget) {
    gtkWindowSetTitlebar(nativePointer.cast(), widget.nativePointer);
  }

  set title(String newTitle) {
    gtkWindowSetTitle(nativePointer.cast(), newTitle);
  }

  set defaultSize(Size size) {
    gtkWindowSetDefaultSize(nativePointer.cast(), size.width, size.height);
  }
}
