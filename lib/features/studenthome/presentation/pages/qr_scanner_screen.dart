import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:student_attendance/core/utils/message_manager.dart';
import 'package:student_attendance/features/studenthome/presentation/bloc/qr_cubit.dart';

import '../../../../injector_container.dart';

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
            buildResult(),
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
    return BlocConsumer<QrCubit, QrScanState>(
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is BarcodeErrorState) {
          sl<MessageManager>().showToastErrorMessage(msg: state.msg);
        } else if (state is BarcodeSuccessState) {
          sl<MessageManager>().showToastSuccessMessage(msg: state.msg);
        }
      },
      builder: (context, state) {
        if (state is BarcodeLoadingState) {
          return CircularProgressIndicator();
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
