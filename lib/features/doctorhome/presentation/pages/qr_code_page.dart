import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:student_attendance/features/doctorhome/presentation/bloc/dr_home_bloc.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode screen'),
      ),
      body: Center(
        child: BlocBuilder<DrHomeBloc, DrHomeState>(
          builder: (context, state) {
            if (state is GenerateQrCodeLoadingState) {
              return CircularProgressIndicator();
            } else if (state is GenerateQrCodeSuccessState) {
              return QrImage(
                data: state.qrCode,
                size: 200.0,
              );
            } else if (state is GenerateQrCodeErrorState) {
              return Text(state.message);
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
