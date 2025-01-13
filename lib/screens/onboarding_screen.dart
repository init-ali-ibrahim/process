// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:process/main.dart';
// import 'package:process/screens/navbar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class OnboardingPage extends StatelessWidget {
//   const OnboardingPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return IntroductionScreen(
//       pages: [
//         PageViewModel(
//           title: "Welcome to my app",
//           body: "This is the first page of our onboarding. Here you can explain the firstfeature of your app.",
//           // image: Image.asset('assets/images/onboarding1.png'),
//         ),
//         PageViewModel(
//           title: "Another feature",
//           body: "This is the second page of our onboarding. Here you can explain another feature of your app.",
//           // image: Image.asset('assets/images/onboarding2.png'),
//         ),
//         PageViewModel(
//           title: "Another title page",
//           body: "Another beautiful body text for this example onboarding",
//           // image: Image.asset('img2.jpg'),
//         ),
//       ],
//       onDone: () async {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('onboardingCompleted', true);
//         final onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
//         print('OnBoard $onboardingCompleted');
//         Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => Navbar(initialPageIndex: 0)),
//               (route) => false,
//         );
//       },
//       dotsDecorator: const DotsDecorator(
//         size: Size(10.0, 10.0),
//         color: Color(0xFFBDBDBD),
//         activeSize: Size(22.0, 10.0),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//       ),
//       showSkipButton: true,
//       skip: const Text('Skip'),
//       next: const Icon(Icons.arrow_forward),
//       done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
//     );
//   }
// }
