import 'package:flutter/material.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/widget/sign_up_widget.dart';

class SignUpAuth extends StatefulWidget {
  const SignUpAuth({super.key});

  @override
  State<SignUpAuth> createState() => _SignUpAuthState();
}

class _SignUpAuthState extends State<SignUpAuth> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/splash/splash.png', fit: BoxFit.cover),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: R.w(context, 24)),
                child: const SignUpWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
