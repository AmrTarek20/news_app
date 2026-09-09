import 'package:flutter/material.dart';
import 'package:news_app/widget/login_widget.dart';
import 'package:news_app/model/responsive.dart';

class LoginAuth extends StatefulWidget {
  final String? prefilledEmail;

  const LoginAuth({super.key, this.prefilledEmail});

  @override
  State<LoginAuth> createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  bool obscurePassword = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/splash/splash.png', fit: BoxFit.cover),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: R.w(context, 24)),
                child: Textfaild(prefilledEmail: widget.prefilledEmail),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
