import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/widget/profile_setting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'مستخدم مصر الآن';
    final userEmail = user?.email ?? 'لا يوجد بريد إلكتروني';
    final userPhoto = user?.photoURL ?? '';

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        title: Text(
          'الملف الشخصي',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: R.sp(context, 15),
            color: Colors.white,
          ),
        ),
        elevation: 7,
        shadowColor: Colors.red[700],
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(R.w(context, 24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: R.h(context, 10)),
            CircleAvatar(
              radius: R.w(context, 50),
              backgroundColor: Colors.red[700],
              backgroundImage: userPhoto.isNotEmpty
                  ? NetworkImage(userPhoto)
                  : null,
              child: userPhoto.isEmpty
                  ? Icon(
                      Icons.person,
                      size: R.sp(context, 50),
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(height: R.h(context, 16)),
            Text(
              userName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: R.sp(context, 20),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: R.h(context, 6)),
            Text(
              userEmail,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: R.sp(context, 14), color: Colors.grey),
            ),
            SizedBox(height: R.h(context, 40)),
            const ProfileSetting(),
          ],
        ),
      ),
    );
  }
}
