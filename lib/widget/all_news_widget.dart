// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/api_service.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/page/details_new.dart';

class AllNewsWidget extends StatefulWidget {
  final String category;

  const AllNewsWidget({super.key, required this.category});

  @override
  State<AllNewsWidget> createState() => _AllNewsWidgetState();
}

class _AllNewsWidgetState extends State<AllNewsWidget> {
  late Future<List<NewsModel>> _newsFuture;

  void _loadNews() {
    if (widget.category == 'الكل') {
      _newsFuture = fetchWorldNewsFromApi();
    } else {
      _newsFuture = fetchNewsFromApi(category: widget.category);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  @override
  void didUpdateWidget(covariant AllNewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.category != widget.category) {
      setState(() {
        _loadNews();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: R.h(context, 300),

            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.red,
                size: R.sp(context, 30),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(
            height: R.h(context, 300),
            child: Center(
              child: Text(
                'خطأ: ${snapshot.error}',
                style: GoogleFonts.cairo(
                  fontSize: R.sp(context, 12),
                  color: Colors.red,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox(
            height: R.h(context, 300),
            child: Center(
              child: Text(
                'عذراً، لا توجد أخبار متاحة',
                style: GoogleFonts.cairo(
                  fontSize: R.sp(context, 14),
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }
        final articles = snapshot.data!;
        final itemCount = articles.length > 30 ? 30 : articles.length;
        return
        
        
         RefreshIndicator(
            onRefresh: () async {
              _loadNews();
            },
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemCount,
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
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: R.w(context, 8),
                    vertical: R.h(context, 6),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(R.radius(context, 12)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: R.sp(context, 6),
                        offset: Offset(0, R.h(context, 3)),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(R.radius(context, 12)),
                        ),
                        child: SizedBox(
                          height: R.h(context, 180),
                          width: double.infinity,
                          child:
                              news.imageUrl != null && news.imageUrl!.isNotEmpty
                              ? Image.network(
                                  news.imageUrl!,
                                  fit: BoxFit.cover,
           
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
           
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: Colors.grey,
                                        size: R.sp(context, 50),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color: Colors.grey[300],
           
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Colors.grey,
                                    size: R.sp(context, 50),
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(R.w(context, 12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              news.title,
                              textDirection: TextDirection.rtl,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: R.sp(context, 15),
                              ),
                            ),
                            SizedBox(height: R.h(context, 6)),
                            Text(
                              news.description,
                              textDirection: TextDirection.rtl,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cairo(
                                color: Colors.black87,
                                fontSize: R.sp(context, 12),
                              ),
                            ),
                            SizedBox(height: R.h(context, 10)),
                            Text(
                              news.sourceName,
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.cairo(
                                color: Colors.red,
                                fontSize: R.sp(context, 11),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
