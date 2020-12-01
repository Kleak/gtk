import 'package:gtk/gtk.dart';

int main() {
  initGtk();

  return CounterApp().run();
}

class CounterApp extends GtkApplication {
  CounterApp() : super('dev.kleak.counter') {
    onActivate.listen(_onActivate);
  }

  void _onActivate(GtkApplicationEvent event) {
    CounterApplicationWindow(event.application);
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
    onDestroy.listen((event) {
      print('we can clean things here');
    });

    final headerbar = GtkHeaderBar();
    headerbar.showCloseButton = true;
    headerbar.title = 'Counter app';
    titleBar = headerbar;

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
