// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/page/discover.dart';
import 'package:news_app/page/home_page.dart';
import 'package:news_app/page/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const Discover(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(R.w(context, 12)),
          child: Container(
            height: R.h(context, 75),
            padding: EdgeInsets.symmetric(
              horizontal: R.w(context, 16),
              vertical: R.h(context, 8),
            ),
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(R.radius(context, 35)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: R.sp(context, 15),
                  offset: Offset(0, -R.h(context, 5)),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFloatingNavItem(
                  icon: Icons.home_outlined,
                  label: 'الرئيسية',
                  index: 0,
                ),
                _buildFloatingNavItem(
                  icon: Icons.explore_outlined,
                  label: 'كل الأخبار',
                  index: 1,
                ),
                _buildFloatingNavItem(
                  icon: Icons.person_outline,
                  label: 'حسابي',
                  index: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0.0,
          isSelected ? -R.h(context, 5) : 0.0,
          0.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: R.w(context, isSelected ? 16 : 12),
          vertical: R.h(context, 8),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.25)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(R.radius(context, 30)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.red[200],
              size: R.sp(context, 24),
            ),
            if (isSelected) ...[
              SizedBox(width: R.w(context, 8)),
              Text(
                label,
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: R.sp(context, 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
