import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/screens/auth/signIn.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Scan QR code"),
        actions: [
          ElevatedButton(onPressed: (){
            Get.to(()=>SignIn());
          }, child: Text("Login as Admin"))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/qrcode.png"),
        ),
      ),
    );
  }
}
