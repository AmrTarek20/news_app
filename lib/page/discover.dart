// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/new_api.dart';
import 'package:news_app/model/new_server.dart';
import 'package:news_app/model/responsive.dart';
import 'package:news_app/page/details_new.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  late Future<List<NewsServer>> _newsFuture;
  final NewApi _newApi = NewApi();

  @override
  void initState() {
    super.initState();
    _newsFuture = _newApi.fetchNewsFromNewsApi();
  }

  void _loadNews() {
    setState(() {
      _newsFuture = _newApi.fetchNewsFromNewsApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(R.h(context, kToolbarHeight)),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(R.radius(context, 25)),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: R.w(context, 4),
                  height: R.h(context, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(R.radius(context, 2)),
                  ),
                ),
                SizedBox(width: R.w(context, 20)),
                Text(
                  'كل الأخبار',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: R.sp(context, 15),
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

      body: FutureBuilder<List<NewsServer>>(
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
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
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
          return RefreshIndicator(
            onRefresh: () async {
              _loadNews();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: R.h(context, 15),
                horizontal: R.w(context, 8),
              ),
              child: ListView.builder(
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
                                (news.content != null &&
                                    news.content!.isNotEmpty)
                                ? news.content!
                                : news.description,
                            newssource: news.sourceName,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: R.h(context, 16)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          R.radius(context, 12),
                        ),
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
                                  news.imageUrl != null &&
                                      news.imageUrl!.isNotEmpty
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
            ),
          );
        },
      ),
    );
  }
}
