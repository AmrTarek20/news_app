// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/auth/login.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/page/main_screens.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;

      final user = FirebaseAuth.instance.currentUser;
      final bool isAuthorized = user != null && user.emailVerified;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isAuthorized ? const MainScreen() : const LoginAuth(),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/splash/splash.png', fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: R.w(context, 24)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: R.w(context, 130),
                    height: R.h(context, 130),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB71C1C),

                      borderRadius: BorderRadius.circular(
                        R.radius(context, 24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: R.sp(context, 12),
                          offset: Offset(0, R.h(context, 6)),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.newspaper_rounded,
                        color: Colors.white,
                        size: R.sp(context, 100),
                      ),
                    ),
                  ),
                  SizedBox(height: R.h(context, 30)),
                  Text(
                    'مصر الآن',
                    style: GoogleFonts.cairo(
                      fontSize: R.sp(context, 45),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: R.h(context, 8)),
                  Text(
                    'آخر الأخبار لحظة بلحظة',
                    style: GoogleFonts.cairo(
                      fontSize: R.sp(context, 16),
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: R.h(context, 40)),
                  SpinKitFadingCircle(
                    color: Colors.red,
                    size: R.sp(context, 30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
