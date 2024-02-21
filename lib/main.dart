import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sustainability/Controllers/loading.dart';
import 'package:sustainability/controllers/powerController.dart';
import 'package:sustainability/screens/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){

  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyBtAbHSECkkmdFRIf82w4kjY-D7d8kCyCA",
      appId: "sustainability-b1665.firebaseapp.com",
      messagingSenderId: "459675636844",
      projectId: "sustainability-b1665",
    storageBucket: "sustainability-b1665.appspot.com",
  ));
  }else{

  await Firebase.initializeApp();
  }
  Get.put(LoadingController());
  Get.put(PowerController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sustainability',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade800,
          foregroundColor: Colors.white
        )
      ),
      home: SplashScreen(),
    );
  }
}
