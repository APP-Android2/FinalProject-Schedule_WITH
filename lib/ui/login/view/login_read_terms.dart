import 'package:flutter/material.dart';

class LoginReadTerms extends StatefulWidget {
  const LoginReadTerms({super.key});

  @override
  State<LoginReadTerms> createState() => _LoginReadTermsState();
}

class _LoginReadTermsState extends State<LoginReadTerms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("약관 보기 화면")
        ],
      ),
    );
  }
}
