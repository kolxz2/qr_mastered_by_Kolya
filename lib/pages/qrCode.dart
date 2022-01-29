import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key, required this.qr}) : super(key: key);

  final String? qr;

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImage(
            data:
                "https://78.29.9.120/prr/hs/HTTPShooter/Find?QR=" + widget.qr!,
            size: 500,
          ),
        ],
      )),
    );
  }
}
