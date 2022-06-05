import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:student_attendance/features/studenthome/presentation/bloc/qr_cubit.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  State<QrScannerScreen> createState() => _QrScannerScreen();
}

class _QrScannerScreen extends State<QrScannerScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildQrView(context),
            Positioned(bottom: 10, child: buildResult()),
          ],
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderColor: Colors.blueAccent,
        borderWidth: 10,
        borderLength: 20,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  Widget buildResult() {
    return BlocBuilder<QrCubit, QrScanState>(
      builder: (context, state) {
        if (state is BarcodeLoadingState) {
          return CircularProgressIndicator();
        } else if (state is BarcodeErrorState) {
          return Text(
            state.msg,
            style: TextStyle(
              fontSize: 30,
              color: Colors.red,
            ),
          );
        } else if (state is BarcodeSuccessState) {
          return Text(
            'success',
            maxLines: 3,
            style: TextStyle(
              fontSize: 30,
              color: Colors.red,
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((barcode) {
      controller.pauseCamera();
      BlocProvider.of<QrCubit>(context).recordStudent(barcode);
    });
  }
}
