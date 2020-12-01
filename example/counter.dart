import 'dart:ffi';

import 'package:gtk/gtk.dart';
import 'package:gtk/src/gtk/application_window.dart';

int main() {
  initGtk();

  return CounterApp().run();
}

class CounterApp extends GtkApplication {
  CounterApp() : super('dev.kleak.counter') {
    onActivate.listen(_onActivate);
  }

  void _onActivate(GtkApplicationActivateEvent event) {
    // final app = GtkApplication.fromNative(event.application);

    // final appWin = GtkApplicationWindow.fromGtkApplication(app);
    // appWin.show();
  }

  @override
  int run() {
    final status = super.run();
    destroy();
    return status;
  }
}

class CounterApplicationWindow extends GtkApplicationWindow {
  int count = 0;

  CounterApplicationWindow(GtkApplication application) : super.fromGtkApplication(application) {
    title = 'Counter';
    defaultSize = Size(200, 200);

    final button = GtkButton.withLabel('You have clicked $count');
    button.onClicked.listen((event) {
      count++;
      button.label = 'You have clicked $count';
    });

    add(button);
    show();
  }
}
