import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:gtk/src/gio/signal.dart';
import 'package:gtk/src/gtk.dart';
import 'package:gtk/src/gtk/bin.dart';
import 'package:gtk/src/gtk/widget.dart';

typedef gtk_button_new_with_label_func = Pointer<Void> Function(Pointer<Utf8>);
typedef GtkButtonNewWithLabel = Pointer<Void> Function(Pointer<Utf8>);

Pointer<Void> gtkButtonNewWithLabel(String label) {
  final f = gtk.lookupFunction<gtk_button_new_with_label_func, GtkButtonNewWithLabel>('gtk_button_new_with_label');
  return f(Utf8.toUtf8(label));
}

typedef gtk_button_set_label_func = Void Function(Pointer<Void>, Pointer<Utf8>);
typedef GtkButtonSetLabel = void Function(Pointer<Void>, Pointer<Utf8>);

void gtkButtonSetLabel(Pointer<Void> button, String label) {
  final f = gtk.lookupFunction<gtk_button_set_label_func, GtkButtonSetLabel>('gtk_button_set_label');
  f(button, Utf8.toUtf8(label));
}

class GtkButtonClickedEvent {
  final GtkWidget widget;
  final Pointer<Void> data;

  const GtkButtonClickedEvent(this.widget, this.data);
}

final _onClickedController = StreamController<GtkButtonClickedEvent>();

void _onButtonClicked(Pointer<Void> widget, Pointer<Void> data) {
  _onClickedController.add(GtkButtonClickedEvent(GtkWidget.fromNative(widget), data));
}

class GtkButton extends GtkBin {
  GtkButton.fromNative(Pointer<Void> nativePointer) : super.fromNative(nativePointer) {
    gSignalConnect(nativePointer.cast(), 'clicked',
        Pointer.fromFunction<Void Function(Pointer<Void>, Pointer<Void>)>(_onButtonClicked), nullptr);
  }

  factory GtkButton.withLabel(String label) => GtkButton.fromNative(gtkButtonNewWithLabel(label));

  Stream<GtkButtonClickedEvent> get onClicked => _onClickedController.stream
      .where((event) => event.widget.nativePointer.address == nativePointer.address)
      .map((event) => null);

  set label(String value) {
    gtkButtonSetLabel(nativePointer, value);
  }
}
