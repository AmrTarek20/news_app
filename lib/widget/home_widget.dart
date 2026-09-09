import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/page/all_news.dart';
import 'package:news_app/widget/catagory.dart';
import 'package:news_app/widget/last_news_widget.dart';
import 'package:news_app/widget/title.dart';
import 'package:news_app/widget/trend_news.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String selectedCategory = 'الكل';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(R.w(context, 8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: R.h(context, 20)),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: R.w(context, 4),
                    height: R.h(context, 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(R.radius(context, 2)),
                    ),
                  ),
                  SizedBox(width: R.w(context, 8)),
                  const SectionTitle(title: 'الأقسام'),
                ],
              ),
              SizedBox(height: R.h(context, 20)),
              CategoriesList(
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              SizedBox(height: R.h(context, 20)),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: R.w(context, 4),
                    height: R.h(context, 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(R.radius(context, 2)),
                    ),
                  ),
                  SizedBox(width: R.w(context, 8)),
                  const SectionTitle(title: 'أهم الأخبار'),
                ],
              ),
              SizedBox(height: R.h(context, 20)),
              TrendNews(category: selectedCategory),
              SizedBox(height: R.h(context, 20)),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: R.w(context, 4),
                    height: R.h(context, 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(R.radius(context, 2)),
                    ),
                  ),
                  SizedBox(width: R.w(context, 8)),
                  const SectionTitle(title: 'أخر الأخبار'),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              AllNews(initialCategory: selectedCategory),
                        ),
                      );
                    },
                    child: Text(
                      'عرض الكل',
                      style: GoogleFonts.cairo(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: R.sp(context, 14),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: R.h(context, 20)),
              LastNewsWidget(category: selectedCategory),
            ],
          ),
        ),
      ),
    );
  }
}
