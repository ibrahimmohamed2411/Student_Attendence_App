import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen1 extends StatefulWidget {
  const QrScreen1({Key? key}) : super(key: key);

  @override
  State<QrScreen1> createState() => _QrScreen1State();
}

class _QrScreen1State extends State<QrScreen1> {
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              QrImage(
                data: controller.text,
                size: 200,
                backgroundColor: Colors.white,
              ),
              TextField(
                controller: controller,
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  print(controller.text);
                  setState(() {});
                },
                child: Text('Generate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
