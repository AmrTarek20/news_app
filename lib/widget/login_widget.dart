// ignore_for_file: await_only_futures, use_build_context_synchronously, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/auth/sign_up.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/page/main_screens.dart';
import 'package:news_app/model/custom_text_form_faild.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Textfaild extends StatefulWidget {
  final String? prefilledEmail;

  const Textfaild({super.key, required this.prefilledEmail});

  @override
  State<Textfaild> createState() => _TextfaildState();
}

class _TextfaildState extends State<Textfaild> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = false;
  bool rememberMe = false;

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider authProvider = GoogleAuthProvider();
        return await FirebaseAuth.instance.signInWithPopup(authProvider);
      } else {
        final googleSignIn = GoogleSignIn.instance;
        final GoogleSignInAccount googleUser = await googleSignIn
            .authenticate();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final clientAuth = await googleUser.authorizationClient.authorizeScopes(
          ['email', 'profile'],
        );

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: clientAuth.accessToken,
        );

        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
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
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.prefilledEmail);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: R.h(context, 35)),
            Container(
              width: R.w(context, 80),
              height: R.h(context, 80),
              decoration: BoxDecoration(
                color: const Color(0xFFB71C1C),
                borderRadius: BorderRadius.circular(R.radius(context, 24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: R.radius(context, 12),
                    offset: Offset(0, R.h(context, 6)),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.newspaper_rounded,
                  color: Colors.white,
                  size: R.sp(context, 40),
                ),
              ),
            ),
            SizedBox(height: R.h(context, 15)),
            Text(
              "مصر الآن",
              style: TextStyle(
                fontSize: R.sp(context, 30),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: R.h(context, 5)),
            Text(
              "أخر الأخبار لحظة بلحظة",
              style: TextStyle(fontSize: R.sp(context, 15), color: Colors.grey),
            ),
            SizedBox(height: R.h(context, 30)),
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                "مرحباً بك ",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: R.h(context, 8)),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                "سجل دخولك لمتابعة آخر الأخبار",
                style: TextStyle(
                  fontSize: R.sp(context, 15),
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: R.h(context, 25)),
            CustomTextFormField(
              controller: emailController,
              hintText: "البريد الإلكتروني",
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "من فضلك أدخل البريد الإلكتروني";
                }
                return null;
              },
            ),
            SizedBox(height: R.h(context, 15)),
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
                  size: R.sp(context, 24),
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
            SizedBox(height: R.h(context, 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    final email = emailController.text.trim();
                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('من فضلك أدخل البريد الإلكتروني'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: email,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'تم إرسال رابط لإعادة تعيين كلمة المرور',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'من فضلك أدخل البريد الإلكتروني الصحيح',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text(
                    "نسيت كلمة المرور؟",
                    style: TextStyle(
                      color: const Color(0xffD30000),
                      fontSize: R.sp(context, 14),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "تذكرني",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: R.sp(context, 14),
                      ),
                    ),
                    Checkbox(
                      value: rememberMe,
                      activeColor: const Color(0xffD30000),
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: R.h(context, 10)),
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
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                          if (!mounted) return;
                          if (userCredential.user!.emailVerified) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          } else {
                            await FirebaseAuth.instance.signOut();

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'برجاء تفعيل بريدك الإلكتروني أولاً. تم إرسال رابط التحقق سابقاً (تأكد من خانة الـ Spam)',
                                ),
                                backgroundColor: Colors.orange,
                                duration: Duration(seconds: 4),
                              ),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (!mounted) return;
                          String errorMessage =
                              'حدث خطأ ما، يرجى المحاولة مرة أخرى';
                          if (e.code == 'user-not-found') {
                            errorMessage =
                                'لا يوجد حساب بهذا البريد الإلكتروني';
                          } else if (e.code == 'wrong-password') {
                            errorMessage = 'كلمة المرور غير صحيحة';
                          } else if (e.code == 'invalid-credential') {
                            errorMessage =
                                'البريد الإلكتروني أو كلمة المرور غير صحيحة';
                          } else if (e.code == 'invalid-email') {
                            errorMessage = 'صيغة البريد الإلكتروني غير صحيحة';
                          } else if (e.code == 'user-disabled') {
                            errorMessage = 'هذا الحساب تم تعطيله';
                          } else if (e.code == 'too-many-requests') {
                            errorMessage =
                                'تم إجراء محاولات كثيرة، حاول مرة أخرى لاحقاً';
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        } finally {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
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
                        "تسجيل الدخول",
                        style: TextStyle(
                          fontSize: R.sp(context, 17),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            SizedBox(height: R.h(context, 25)),
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
            SizedBox(height: R.h(context, 20)),
            // Google Login
            SizedBox(
              width: double.infinity,
              height: R.h(context, 55),
              child: OutlinedButton(
                onPressed: () async {
                  final userCredential = await signInWithGoogle(context);
                  if (!context.mounted) return;
                  if (userCredential != null && userCredential.user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
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
            SizedBox(height: R.h(context, 25)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ليس لديك حساب؟ ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: R.sp(context, 14),
                  ),
                ),
                SizedBox(height: R.h(context, 10)),
                SizedBox(
                  width: double.infinity,
                  height: R.h(context, 55),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const SignUpAuth(),
                        ),
                        (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: const Color(0xffD30000),
                        width: R.w(context, 1),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          R.radius(context, 12),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_add_alt,
                          color: const Color(0xffD30000),
                          size: R.sp(context, 24),
                        ),
                        SizedBox(width: R.w(context, 15)),
                        Text(
                          "إنشاء حساب جديد",
                          style: TextStyle(
                            color: const Color(0xffD30000),
                            fontSize: R.sp(context, 14),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: R.h(context, 20)),
          ],
        ),
      ),
    );
  }
}
