import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static void show(String message) {
    if (message.isEmpty) return;
    Fluttertoast.showToast(msg: message);
  }

  static void cancel() {
    Fluttertoast.cancel();
  }
}
