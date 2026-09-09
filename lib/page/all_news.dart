import 'package:flutter/material.dart';
import 'package:news_app/widget/all_news_widget.dart';
import 'package:news_app/widget/title.dart';
import 'package:news_app/model/responsive.dart';

class AllNews extends StatefulWidget {
  const AllNews({super.key, required this.initialCategory});

  final String initialCategory;

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  final ScrollController _scrollController = ScrollController();

  String get initialCategory => widget.initialCategory;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: R.sp(context, 20)),
                ),
              ],
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: R.w(context, 4),
                    height: R.h(context, 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(R.radius(context, 2)),
                    ),
                  ),
                  SizedBox(width: R.w(context, 20)),
                  const SectionTitle(title: 'كل الأخبار'),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(child: AllNewsWidget(category: initialCategory)),
      ),
    );
  }
}
