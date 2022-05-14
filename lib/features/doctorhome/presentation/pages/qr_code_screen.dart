import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../injector_container.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode screen'),
      ),
      body: Center(
        child: QrImage(
          data: sl<FirebaseAuth>().currentUser!.uid,
          //ToDo:rebuild this line of code to be good more
          size: 250,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.download),
      ),
    );
  }
}
