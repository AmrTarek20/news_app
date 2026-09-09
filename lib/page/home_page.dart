import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/widget/home_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(R.h(context, kToolbarHeight)),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(R.radius(context, 25)),
            ),
            child: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "مصر",
                    style: GoogleFonts.cairo(
                      fontSize: R.sp(context, 20),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: R.w(context, 5)),
                  Text(
                    'الآن',
                    style: GoogleFonts.cairo(
                      fontSize: R.sp(context, 20),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              elevation: 7,
              shadowColor: Colors.red[700],
              backgroundColor: Colors.red[700],
            ),
          ),
        ),
        body: const HomeWidget(),
      ),
    );
  }
}
