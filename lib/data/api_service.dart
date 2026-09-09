import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class ApiService {
  Future<List<NewsModel>> getNews() async {
    try {
      var url = Uri.parse(
        'https://gnews.io/api/v4/top-headlines?category=general&lang=ar&country=eg&max=10&apikey=831139fc1c53fc89a8964073eb35c576',
      );

      var response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'] ?? [];

        return articles
            .map((jsonItem) => NewsModel.fromJson(jsonItem))
            .toList();
      } else {
        throw Exception(
          'Failed to load news, status code: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      // ignore: avoid_print
      print('CRITICAL ERROR: $e');
      // ignore: avoid_print
      print('STACK TRACE: $stackTrace');
      return [];
    }
  }
}

// Function to fetch news from the API
Future<List<NewsModel>> fetchNewsFromApi({String category = 'الكل'}) async {
  // تحويل اسم القسم العربي إلى الرابط أو الـ Category الخاص بالـ API
  String apiCategory = 'general';

  switch (category) {
    case 'تكنولوجيا':
      apiCategory = 'technology';
      break;
    case 'رياضة':
      apiCategory = 'sports';
      break;
    case 'اقتصاد':
      apiCategory = 'business';
      break;
    case 'سياسة':
      apiCategory = 'politics';
      break;
    case 'مصر':
      apiCategory = 'nation';
      break;
    case 'الكل':
    default:
      apiCategory = 'general';
      break;
  }

  final url = Uri.parse(
    'https://gnews.io/api/v4/top-headlines?category=$apiCategory&lang=ar&country=eg&max=10&apikey=831139fc1c53fc89a8964073eb35c576',
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'] ?? [];

      return articles.map((jsonItem) => NewsModel.fromJson(jsonItem)).toList();
    } else {
      throw Exception(
        'فشل في تحميل الأخبار (كود الخطأ: ${response.statusCode})',
      );
    }
  } catch (e) {
    throw Exception('حدث خطأ أثناء الاتصال: $e');
  }
}

// Function to fetch world news from the API
Future<List<NewsModel>> fetchWorldNewsFromApi() async {
  final url = Uri.parse(
    'https://gnews.io/api/v4/top-headlines?category=general&lang=ar&max=10&apikey=831139fc1c53fc89a8964073eb35c576',
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'] ?? [];

      return articles.map((jsonItem) => NewsModel.fromJson(jsonItem)).toList();
    } else {
      throw Exception(
        'فشل في تحميل أخبار العالم (كود الخطأ: ${response.statusCode})',
      );
    }
  } catch (e) {
    throw Exception('حدث خطأ أثناء الاتصال: $e');
  }
}
