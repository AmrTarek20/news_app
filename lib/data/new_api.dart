import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/new_server.dart';

class NewApi {
  Future<List<NewsServer>> fetchNewsFromNewsApi({
    String category = 'الكل',
  }) async {
    String query = 'عالمي OR محلي OR مصر OR اخبار';

    if (category == 'تكنولوجيا') {
      query = 'تكنولوجيا OR تقنية OR ذكاء اصطناعي OR هواتف';
    } else if (category == 'رياضة') {
      query = 'رياضة OR كرة قدم OR دوري OR مباريات';
    } else if (category == 'اقتصاد') {
      query = 'اقتصاد OR أسهم OR أسعار OR تجارة OR مال';
    }

    final url = Uri.parse(
      'https://newsapi.org/v2/everything'
      '?q=$query'
      '&language=ar'
      '&sortBy=publishedAt'
      '&apiKey=0e32eb165a6747208ba51495948424fe',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List articles = data['articles'] ?? [];

        final List<NewsServer> news = [];

        for (final article in articles) {
          try {
            final newsItem = NewsServer.fromJson(article);

            // تجاهل الأخبار اللي ملهاش عنوان
            if (newsItem.title == 'بدون عنوان') {
              continue;
            }

            // تجاهل الأخبار المحذوفة
            if (newsItem.title == '[Removed]') {
              continue;
            }

            news.add(newsItem);
          } catch (e) {
            // لو Article واحد فيه مشكلة
            // نكمل باقي الأخبار عادي
            continue;
          }
        }

        return news;
      } else {
        throw Exception('فشل التحميل من السيرفر: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('حدث خطأ: $e');
    }
  }
}
