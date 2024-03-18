
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

Future<bool?> showToastWidgetError(String message) {
  return Fluttertoast.showToast(
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #ff0000, #ff0000, #ff0000)",
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      textColor:  Constants.primaryColor,
      fontSize: 16.0);
}


Future<bool?> showToastWidgetSuccess(String message) {
  return Fluttertoast.showToast(
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #00ff00, #00ff00, #00ff00)",
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      textColor:  Constants.primaryColor,
      fontSize: 16.0);
}