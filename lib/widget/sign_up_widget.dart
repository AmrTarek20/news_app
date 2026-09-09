// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/auth/login.dart';
import 'package:news_app/model/custom_text_form_faild.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/page/main_screens.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeToTerms = false;
  bool isLoading = false;

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final clientAuth = await googleUser.authorizationClient.authorizeScopes([
        'email',
        'profile',
      ]);

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: clientAuth.accessToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // ignore: avoid_print
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ أثناء تسجيل الدخول بجوجل: ${e.toString()}'),
            backgroundColor: const Color(0xffD30000),
          ),
        );
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: R.h(context, 12)),
          Container(
            width: R.w(context, 80),
            height: R.h(context, 80),
            decoration: BoxDecoration(
              color: const Color(0xffD30000),
              borderRadius: BorderRadius.circular(R.radius(context, 20)),
            ),
            child: Icon(
              Icons.newspaper_rounded,
              color: Colors.white,
              size: R.sp(context, 48),
            ),
          ),
          SizedBox(height: R.h(context, 12)),
          Text(
            "مصر الآن",
            style: TextStyle(
              fontSize: R.sp(context, 28),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: R.h(context, 5)),
          Text(
            "أهم الأخبار لحظة بلحظة",
            style: TextStyle(fontSize: R.sp(context, 14), color: Colors.grey),
          ),
          SizedBox(height: R.h(context, 35)),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "إنشاء حساب جديد",
              style: TextStyle(
                fontSize: R.sp(context, 25),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: R.h(context, 7)),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "انضم إلينا واستمتع بتجربة مميزة",
              style: TextStyle(fontSize: R.sp(context, 14), color: Colors.grey),
            ),
          ),
          SizedBox(height: R.h(context, 22)),
          CustomTextFormField(
            controller: nameController,
            hintText: "الاسم الكامل",
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "من فضلك أدخل الاسم";
              }
              return null;
            },
          ),
          SizedBox(height: R.h(context, 13)),
          CustomTextFormField(
            controller: emailController,
            hintText: "البريد الإلكتروني",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "من فضلك أدخل البريد الإلكتروني";
              }
              if (!value.contains("@")) {
                return "البريد الإلكتروني غير صحيح";
              }
              return null;
            },
          ),
          SizedBox(height: R.h(context, 13)),
          CustomTextFormField(
            controller: passwordController,
            hintText: "كلمة المرور",
            prefixIcon: Icons.lock_outline,
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
                size: R.sp(context, 22),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "من فضلك أدخل كلمة المرور";
              }

              if (value.length < 6) {
                return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
              }

              return null;
            },
          ),

          SizedBox(height: R.h(context, 13)),
          CustomTextFormField(
            controller: confirmPasswordController,
            hintText: "تأكيد كلمة المرور",
            prefixIcon: Icons.lock_outline,
            obscureText: obscureConfirmPassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
              icon: Icon(
                obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
                size: R.sp(context, 22),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "من فضلك أكد كلمة المرور";
              }

              if (value != passwordController.text) {
                return "كلمة المرور غير متطابقة";
              }

              return null;
            },
          ),

          SizedBox(height: R.h(context, 12)),

          // Terms
          Row(
            children: [
              Checkbox(
                value: agreeToTerms,
                activeColor: const Color(0xffD30000),
                onChanged: (value) {
                  setState(() {
                    agreeToTerms = value ?? false;
                  });
                },
              ),
              Expanded(
                child: Text(
                  "أوافق على الشروط والأحكام وسياسة الخصوصية",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: R.sp(context, 12),
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: R.h(context, 8)),
          SizedBox(
            width: double.infinity,
            height: R.h(context, 55),
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      if (!agreeToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'يجب الموافقة على الشروط والأحكام للمتابعة',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                        await userCredential.user?.updateDisplayName(
                          nameController.text.trim(),
                        );
                        await userCredential.user?.sendEmailVerification();
                        if (!mounted) return;
                        final registeredEmail = emailController.text.trim();
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'نجاح',
                          desc:
                              'تم إنشاء الحساب وإرسال رابط التحقق إلى بريدك الإلكتروني (تأكد من خانة الـ Spam)',
                          btnOkOnPress: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    LoginAuth(prefilledEmail: registeredEmail),
                              ),
                              (route) => false,
                            );
                          },
                        ).show();
                      } on FirebaseAuthException catch (e) {
                        if (!mounted) return;
                        String errorMessage = 'حدث خطأ ما، حاول مرة أخرى';
                        if (e.code == 'email-already-in-use') {
                          errorMessage = 'هذا البريد الإلكتروني مستخدم من قبل';
                        } else if (e.code == 'weak-password') {
                          errorMessage = 'كلمة المرور ضعيفة للغاية';
                        } else if (e.code == 'invalid-email') {
                          errorMessage = 'صيغة البريد الإلكتروني غير صحيحة';
                        }
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'رسالة خطأ',
                          desc: errorMessage,
                          btnOkOnPress: () {},
                        ).show();
                      } finally {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffD30000),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(R.radius(context, 12)),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      width: R.w(context, 24),
                      height: R.h(context, 24),
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: R.sp(context, 2.5),
                      ),
                    )
                  : Text(
                      "إنشاء الحساب",
                      style: TextStyle(
                        fontSize: R.sp(context, 17),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          SizedBox(height: R.h(context, 22)),
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: R.w(context, 15)),
                child: Text(
                  "أو",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: R.sp(context, 14),
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),
          SizedBox(height: R.h(context, 18)),
          // Google Sign Up
          SizedBox(
            width: double.infinity,
            height: R.h(context, 55),
            child: OutlinedButton(
              onPressed: () async {
                final userCredential = await signInWithGoogle(context);
                if (!context.mounted) return;
                if (userCredential != null && userCredential.user != null) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false,
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(R.radius(context, 12)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "التسجيل بواسطة Google",
                    style: GoogleFonts.poppins(
                      fontSize: R.sp(context, 14),
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: R.w(context, 10)),
                  Image.asset(
                    "assets/img/google.png",
                    width: R.w(context, 30),
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: R.h(context, 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "لديك حساب بالفعل؟ ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: R.sp(context, 14),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginAuth()),
                    (route) => false,
                  );
                },
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    color: const Color(0xffD30000),
                    fontSize: R.sp(context, 14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: R.h(context, 20)),
        ],
      ),
    );
  }
}
