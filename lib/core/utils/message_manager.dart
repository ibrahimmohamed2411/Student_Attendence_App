import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class MessageManager {
  Future<void> showToastMessage({
    required String msg,
  });
  Future<void> showToastErrorMessage({required String msg});
  Future<void> showToastSuccessMessage({required String msg});
}

class MessageManagerImp implements MessageManager {
  @override
  Future<void> showToastMessage({required String msg}) async {
    await Fluttertoast.showToast(
      msg: msg,
    );
  }

  @override
  Future<void> showToastErrorMessage({required String msg}) async {
    await Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.red,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Future<void> showToastSuccessMessage({required String msg}) async {
    await Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.green,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
