import 'package:flutter/material.dart';

class UITest extends StatefulWidget {
  const UITest({Key? key}) : super(key: key);

  @override
  State<UITest> createState() => _UITestState();
}

class _UITestState extends State<UITest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ui Widget'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            // print(d.exists);
          },
          child: Text('Click here'),
        ),
      ),
    );
  }
}
