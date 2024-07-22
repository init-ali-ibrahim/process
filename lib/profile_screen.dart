import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen2 extends StatefulWidget {
  @override
  _ProfileScreen2State createState() => _ProfileScreen2State();
}

class _ProfileScreen2State extends State<ProfileScreen2> {
  // final User? user = FirebaseAuth.instance.currentUser;
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Profile'),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('Email: ${user?.email ?? 'N/A'}', style: TextStyle(fontSize: 18)),
  //           SizedBox(height: 8),
  //           Text('First Name: ${user?.displayName?.split(' ').first ?? 'N/A'}', style: TextStyle(fontSize: 18)),
  //           SizedBox(height: 8),
  //           Text('Last Name: ${user?.displayName?.split(' ').last ?? 'N/A'}', style: TextStyle(fontSize: 18)),
  //           SizedBox(height: 8),
  //           Text('Phone Number: ${user?.phoneNumber ?? 'N/A'}', style: TextStyle(fontSize: 18)),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: () async {
  //               await FirebaseAuth.instance.signOut();
  //               Navigator.pushReplacementNamed(context, '/login');
  //             },
  //             child: Text('Sign Out'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Phone Number: ${user?.phoneNumber ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class ProfileScreen2 extends StatefulWidget {
//   @override
//   _ProfileScreen2State createState() => _ProfileScreen2State();
// }
//
// class _ProfileScreen2State extends State<ProfileScreen2> {
//   final User? user = FirebaseAuth.instance.currentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Email: ${user?.email ?? 'N/A'}', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 8),
//             Text('First Name: ${user?.displayName?.split(' ').first ?? 'N/A'}', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 8),
//             Text('Last Name: ${user?.displayName?.split(' ').last ?? 'N/A'}', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 8),
//             Text('Phone Number: ${user?.phoneNumber ?? 'N/A'}', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await FirebaseAuth.instance.signOut();
//                 Navigator.pushReplacementNamed(context, '/login');
//               },
//               child: Text('Sign Out'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }