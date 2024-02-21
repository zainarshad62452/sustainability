import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sustainability/screens/buildingsPage.dart';

// Import Firebase authentication if needed
// import 'firebaseAuth.dart';

class PowerConsumptionIntro extends StatefulWidget {
  @override
  _PowerConsumptionIntroState createState() => _PowerConsumptionIntroState();
}

class _PowerConsumptionIntroState extends State<PowerConsumptionIntro> {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: '',
        image: Image.asset(
          'assets/energy_saving.png',
          // fit: BoxFit.cover,
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Save Energy',
              style: GoogleFonts.lato(
                  fontSize: 30, fontWeight: FontWeight.w900),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Learn how to reduce your energy consumption and save on bills.',
                style: GoogleFonts.lato(
                    fontSize: 25,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
      PageViewModel(
        title: '',
        image: Image.asset(
          'assets/environment.png',
          // fit: BoxFit.cover,
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Protect the Environment',
              style: GoogleFonts.lato(
                  fontSize: 30, fontWeight: FontWeight.w900),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Understand how your energy usage impacts the environment and ways to minimize it.',
                style: GoogleFonts.lato(
                    fontSize: 25,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: getPages(),
        showNextButton: false,
        showSkipButton: true,
        skip: SizedBox(
          width: 80,
          height: 48,
          child: Card(
            child: Center(
              child: Text(
                'Skip',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    fontSize: 25, fontWeight: FontWeight.w900),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            color: Colors.tealAccent.shade700,
            shadowColor: Colors.tealAccent.shade100,
            elevation: 5,
          ),
        ),
        done: SizedBox(
          height: 48,
          child: Card(
            child: Center(
              child: Text(
                'Continue',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            color: Colors.tealAccent.shade700,
            shadowColor: Colors.tealAccent.shade100,
            elevation: 5,
          ),
        ),
        onDone: () {
          Get.offAll(()=>BuildingPage());
        },
      ),
    );
  }

// void _pushPage(BuildContext context, Widget page) {
//   Navigator.of(context).push(
//     MaterialPageRoute<void>(builder: (_) => page),
//   );
// }
}
