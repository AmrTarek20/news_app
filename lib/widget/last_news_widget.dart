import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/api_service.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/page/details_new.dart';

class LastNewsWidget extends StatefulWidget {
  final String category;

  const LastNewsWidget({super.key, required this.category});

  @override
  State<LastNewsWidget> createState() => _LastNewsWidgetState();
}

class _LastNewsWidgetState extends State<LastNewsWidget> {
  late Future<List<NewsModel>> _newsFuture;

  @override
  void didUpdateWidget(covariant LastNewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.category != widget.category) {
      setState(() {
        _newsFuture = fetchNewsFromApi(category: widget.category);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _newsFuture = fetchNewsFromApi(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: R.h(context, 220),
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
            height: R.h(context, 220),
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
            height: R.h(context, 220),
            child: Center(
              child: Text(
                'عذراً، لا يمكن تحميل الأخبار الأخيرة',
                style: GoogleFonts.cairo(
                  fontSize: R.sp(context, 14),
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }
        final articles = snapshot.data!;
        final itemCount = articles.length > 20 ? 20 : articles.length;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
                  vertical: R.h(context, 4),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(R.radius(context, 8)),
                  color: Colors.grey[200],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: R.w(context, 8),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(R.radius(context, 8)),
                    child: Container(
                      width: R.w(context, 60),
                      height: R.h(context, 60),
                      color: Colors.grey[300],
                      child: news.imageUrl != null && news.imageUrl!.isNotEmpty
                          ? Image.network(
                              news.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                  size: R.sp(context, 30),
                                );
                              },
                            )
                          : Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                              size: R.sp(context, 30),
                            ),
                    ),
                  ),
                  title: Text(
                    news.title,
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: R.sp(context, 13),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.description,
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                          color: Colors.grey,
                          fontSize: R.sp(context, 11),
                        ),
                      ),
                      SizedBox(height: R.h(context, 4)),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          news.sourceName,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.cairo(
                            color: Colors.red,
                            fontSize: R.sp(context, 10),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
