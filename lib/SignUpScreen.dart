import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // bool _obscureText = true;
  //
  //
  // Future<void> _signUp() async {
  //   try {
  //     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     );
  //     print('User registered: ${userCredential.user!.email}');
  //
  //   } on FirebaseAuthException catch (e) {
  //     print('Error: ${e.message}');
  //   }
  // }
  //
  // void _togglePasswordVisibility() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: PreferredSize(
  //       preferredSize: const Size.fromHeight(200),
  //       child: AppBar(
  //         backgroundColor: Color(0xFF772067),
  //         elevation: 0,
  //         leading: IconButton(
  //           icon: const Icon(Icons.arrow_back, color: Colors.white),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //         flexibleSpace: const Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 16.0),
  //               child: Text(
  //                 'Register',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 42,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 16.0),
  //               child: Text(
  //                 'Please enter your email to register',
  //                 style: TextStyle(
  //                   color: Color(0xFFE0E0E0),
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //           ],
  //         ),
  //       ),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const SizedBox(height: 40.0),
  //             TextField(
  //               controller: _emailController,
  //               decoration: InputDecoration(
  //                 labelText: 'Email',
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //                 filled: true,
  //                 fillColor: Color(0x13621455),
  //               ),
  //             ),
  //             const SizedBox(height: 20.0),
  //             TextField(
  //               controller: _passwordController,
  //               obscureText: _obscureText,
  //               decoration: InputDecoration(
  //                 labelText: 'Password',
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //                 filled: true,
  //                 fillColor: Color(0x13621455),
  //                 suffixIcon: IconButton(
  //                   icon: Icon(
  //                     _obscureText ? Icons.visibility_off : Icons.visibility,
  //                     // Icons.visibility_off
  //                   ),
  //                   onPressed:
  //                   // () => widget
  //                   _togglePasswordVisibility,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 20.0),
  //             TextField(
  //               controller: _passwordController,
  //               decoration: InputDecoration(
  //                 labelText: 'Name',
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //                 filled: true,
  //                 fillColor: Color(0x13621455),
  //               ),
  //             ),
  //             const SizedBox(height: 20.0),
  //             TextField(
  //               controller: _passwordController,
  //               decoration: InputDecoration(
  //                 labelText: 'LastName',
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //                 filled: true,
  //                 fillColor: Color(0x13621455),
  //               ),
  //             ),
  //             const SizedBox(height: 20.0),
  //             SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Color(0xFF953282),
  //                   padding: const EdgeInsets.symmetric(vertical: 15.0),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8.0),
  //                   ),
  //                 ),
  //                 onPressed: _signUp,
  //                 child: const Text(
  //                   'Register',
  //                   style: TextStyle(color: Colors.white, fontSize: 16),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 20.0),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }


  // final _formKey = GlobalKey<FormState>();
  // final _auth = FirebaseAuth.instance;
  //
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _firstNameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  //
  // void _register() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //
  //       // Update user profile with additional info
  //       await userCredential.user!.updateProfile(
  //         displayName: "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}",
  //       );
  //
  //       // Verify phone number if provided
  //       if (_phoneController.text.isNotEmpty) {
  //         await _verifyPhoneNumber(userCredential.user!, _phoneController.text.trim());
  //       }
  //
  //       // Reload the user to update the profile information
  //       await userCredential.user!.reload();
  //
  //       Navigator.pushReplacementNamed(context, '/login');
  //     } on FirebaseAuthException catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
  //     }
  //   }
  // }
  //
  // Future<void> _verifyPhoneNumber(User user, String phoneNumber) async {
  //   // Send SMS verification code
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       // Automatically signs the user in on Android
  //       await user.updatePhoneNumber(credential);
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Phone number verified and added to user')));
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Phone verification failed: ${e.message}')));
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       // Manually sign in the user
  //       String smsCode = await _getSMSCodeFromUser();
  //
  //       PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId,
  //         smsCode: smsCode,
  //       );
  //
  //       await user.updatePhoneNumber(credential);
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Phone number verified and added to user')));
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       // Auto-retrieval timeout
  //     },
  //   );
  // }
  //
  // Future<String> _getSMSCodeFromUser() async {
  //   // Show dialog to enter SMS code
  //   String smsCode = '';
  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Enter SMS Code'),
  //         content: TextField(
  //           onChanged: (value) {
  //             smsCode = value;
  //           },
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   return smsCode;
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Registration'),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Form(
  //         key: _formKey,
  //         child: ListView(
  //           children: [
  //             TextFormField(
  //               controller: _emailController,
  //               decoration: InputDecoration(labelText: 'Email'),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your email';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               controller: _firstNameController,
  //               decoration: InputDecoration(labelText: 'First Name'),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your first name';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               controller: _lastNameController,
  //               decoration: InputDecoration(labelText: 'Last Name'),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your last name';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               controller: _passwordController,
  //               decoration: InputDecoration(labelText: 'Password'),
  //               obscureText: true,
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your password';
  //                 }
  //                 if (value.length < 6) {
  //                   return 'Password must be at least 6 characters';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               controller: _confirmPasswordController,
  //               decoration: InputDecoration(labelText: 'Confirm Password'),
  //               obscureText: true,
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please confirm your password';
  //                 }
  //                 if (value != _passwordController.text) {
  //                   return 'Passwords do not match';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               controller: _phoneController,
  //               decoration: InputDecoration(labelText: 'Phone Number (optional)'),
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: _register,
  //               child: Text('Register'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pushNamed(context, '/login');
  //               },
  //               child: Text('Already have an account? Login here'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }


  // ----

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _smsCodeController = TextEditingController();
  // String? _verificationId;
  //
  // void _verifyPhoneNumber() async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: _phoneController.text,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await _auth.signInWithCredential(credential);
  //       Navigator.pushReplacementNamed(context, '/profile');
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verification failed: ${e.message}')));
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       setState(() {
  //         _verificationId = verificationId;
  //       });
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       setState(() {
  //         _verificationId = verificationId;
  //       });
  //     },
  //   );
  // }
  //
  // void _signInWithSMSCode() async {
  //   if (_verificationId != null) {
  //     try {
  //       PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: _verificationId!,
  //         smsCode: _smsCodeController.text,
  //       );
  //       await _auth.signInWithCredential(credential);
  //       Navigator.pushReplacementNamed(context, '/profile2');
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid code')));
  //     }
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Login'),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           TextField(
  //             controller: _phoneController,
  //             decoration: InputDecoration(labelText: 'Phone Number'),
  //             keyboardType: TextInputType.phone,
  //           ),
  //           ElevatedButton(
  //             onPressed: _verifyPhoneNumber,
  //             child: Text('Verify Phone Number'),
  //           ),
  //           TextField(
  //             controller: _smsCodeController,
  //             decoration: InputDecoration(labelText: 'SMS Code'),
  //             keyboardType: TextInputType.number,
  //           ),
  //           ElevatedButton(
  //             onPressed: _signInWithSMSCode,
  //             child: Text('Sign In'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _phoneNumber = '';
  String _verificationId = '';
  String _smsCode = '';

  Future<void> _verifyPhoneNumber() async {
    if (_phoneNumber.isEmpty) {
      // Обработка пустого номера
      return;
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          // Обработка ошибки
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e.toString());
      // Обработка ошибки
    }
  }

  Future<void> _signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsCode,
      );
      await _auth.signInWithCredential(credential);
      // Успешная регистрация
    } catch (e) {
      print(e.toString());
      // Обработка ошибки
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Регистрация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntlPhoneField(
              decoration: InputDecoration(labelText: 'Номер телефона'),
              initialCountryCode: 'KZ',
              onChanged: (phone) => setState(() => _phoneNumber = phone.completeNumber),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: Text('Отправить код'),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Код из SMS'),
              onChanged: (value) => setState(() => _smsCode = value),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signInWithPhoneNumber,
              child: Text('Подтвердить'),
            ),
          ],
        ),
      ),
    );
  }



}