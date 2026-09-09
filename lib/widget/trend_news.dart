// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/api_service.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/page/details_new.dart';

class TrendNews extends StatefulWidget {
  final String category;

  const TrendNews({super.key, required this.category});

  @override
  State<TrendNews> createState() => _TrendNewsState();
}

class _TrendNewsState extends State<TrendNews> {
  final PageController _pageController = PageController();
  late Future<List<NewsModel>> _newsFuture;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadNews();
    _startAutoScroll();
  }

  void _loadNews() {
    if (widget.category == 'الكل') {
      _newsFuture = fetchWorldNewsFromApi();
    } else {
      _newsFuture = fetchNewsFromApi(category: widget.category);
    }
  }

  @override
  void didUpdateWidget(covariant TrendNews oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.category != widget.category) {
      setState(() {
        _loadNews();
        _currentPage = 0;
      });
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentPage + 1;

        if (nextPage >= 3) {
          nextPage = 0;
        }

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCirc,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: R.h(context, 230),
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.red,
                size: R.sp(context, 30),
              ),
            ),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox(
            height: R.h(context, 230),
            child: Center(
              child: Text(
                'عذراً، لا يمكن تحميل الأخبار البارزة',
                style: GoogleFonts.cairo(
                  fontSize: R.sp(context, 14),
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }
        final articles = snapshot.data!;
        final itemCount = articles.length > 3 ? 3 : articles.length;
        return Container(
          height: R.h(context, 230),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(R.radius(context, 16)),
          ),
          child: PageView.builder(
            controller: _pageController,
            reverse: true,
            itemCount: itemCount,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final news = articles[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailsNew(
                        newsTitle: news.title,
                        newsimageUrl: news.imageUrl ?? '',
                        newsContent:
                            (news.content != null && news.content!.isNotEmpty)
                            ? news.content!
                            : news.description,
                        newssource: news.sourceName,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(R.w(context, 8)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        R.radius(context, 16),
                      ),
                      color: Colors.grey[300],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        R.radius(context, 16),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child:
                                news.imageUrl != null &&
                                    news.imageUrl!.isNotEmpty
                                ? Image.network(
                                    news.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[400],
                                        child: Center(
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            color: Colors.white,
                                            size: R.sp(context, 40),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    color: Colors.grey[400],
                                    child: Center(
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: Colors.white,
                                        size: R.sp(context, 40),
                                      ),
                                    ),
                                  ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                R.radius(context, 16),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            padding: EdgeInsets.all(R.w(context, 16)),
                            alignment: Alignment.bottomRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news.title,
                                  textDirection: TextDirection.rtl,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontSize: R.sp(context, 16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: R.h(context, 8)),
                                Text(
                                  news.sourceName,
                                  textDirection: TextDirection.rtl,
                                  style: GoogleFonts.cairo(
                                    color: Colors.white70,
                                    fontSize: R.sp(context, 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
