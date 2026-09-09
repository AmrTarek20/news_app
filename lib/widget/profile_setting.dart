// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/login.dart';
import 'package:news_app/model/responsive.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({super.key});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  bool isLoggingOut = false;

  Future<void> logout() async {
    if (isLoggingOut) return;

    setState(() {
      isLoggingOut = true;
    });

    try {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginAuth()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoggingOut = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(R.radius(context, 16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: R.sp(context, 10),
            offset: Offset(0, R.h(context, 4)),
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: R.w(context, 16),
              ),
              leading: Icon(
                Icons.info_outline,
                color: Colors.grey,
                size: R.sp(context, 24),
              ),
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'حول التطبيق (About Us)',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: R.sp(context, 15),
                  ),
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: R.sp(context, 16),
                color: Colors.grey,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          R.radius(context, 20),
                        ),
                      ),
                      title: const Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'حول التطبيق',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      content: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.newspaper_rounded,
                              color: const Color(0xffD30000),
                              size: R.sp(context, 55),
                            ),
                            SizedBox(height: R.h(context, 15)),
                            const Text(
                              'مصر الآن',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: R.h(context, 8)),
                            const Text(
                              'تطبيق مصر الآن هو تطبيق تجريبي ويمنحك آخر الأخبار المحلية والعالمية لحظة بلحظة.',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                height: 1.6,
                              ),
                            ),
                            SizedBox(height: R.h(context, 15)),
                            const Text(
                              'الإصدار 1.0.0',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'إغلاق',
                            style: TextStyle(
                              color: Color(0xffD30000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showLicensePage(
                              context: context,
                              applicationName: 'مصر الآن',
                              applicationVersion: '1.0.0',
                            );
                          },
                          child: const Text(
                            'التراخيص',
                            style: TextStyle(
                              color: Color(0xffD30000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Divider(
              height: R.h(context, 1),
              indent: R.w(context, 16),
              endIndent: R.w(context, 16),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: R.w(context, 16),
              ),
              onTap: logout,
              leading: isLoggingOut
                  ? SizedBox(
                      width: R.sp(context, 24),
                      height: R.sp(context, 24),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xffD30000),
                      ),
                    )
                  : Icon(
                      Icons.logout,
                      color: const Color(0xffD30000),
                      size: R.sp(context, 24),
                    ),
              title: Text(
                isLoggingOut ? 'جاري تسجيل الخروج...' : 'تسجيل الخروج',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: R.sp(context, 15),
                  color: const Color(0xffD30000),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
