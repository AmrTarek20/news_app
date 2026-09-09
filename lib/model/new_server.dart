class NewsServer {
  final String title;
  final String description;
  final String? content;
  final String? imageUrl;
  final String url;
  final String publishedAt;
  final String sourceName;

  NewsServer({
    required this.title,
    required this.description,
    this.content,
    this.imageUrl,
    required this.url,
    required this.publishedAt,
    required this.sourceName,
  });

  factory NewsServer.fromJson(Map<String, dynamic> json) {
    String cleanText(dynamic value) {
      if (value == null) return '';

      String text = value.toString();
      text = text.replaceAll(RegExp(r'<[^>]*>', multiLine: true), ' ');
      text = text.replaceAll(
        RegExp(r'\[\+\d+\s*chars?\]', caseSensitive: false),
        '',
      );
      text = text
          .replaceAll('&nbsp;', ' ')
          .replaceAll('&amp;', '&')
          .replaceAll('&quot;', '"')
          .replaceAll('&#39;', "'")
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>');

      // التعديل البسيط لتنظيف علامات التنصيص الفارغة والزائدة
      text = text.replaceAll('""', '').replaceAll("''", '');

      text = text.replaceAll(
        RegExp(r'https?:\/\/\S+|www\.\S+', caseSensitive: false),
        '',
      );
      text = text.replaceAll(RegExp(r'\s+'), ' ');
      return text.trim();
    }

    String limitText(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      }
      return '${text.substring(0, maxLength).trim()}...';
    }

    String title = cleanText(json['title']);

    if (title.isEmpty || title == '[Removed]') {
      title = 'بدون عنوان';
    }

    String description = cleanText(json['description']);
    if (description.isEmpty || description == '[Removed]') {
      description = 'لا يوجد وصف متاح لهذا الخبر حالياً.';
    }

    description = limitText(description, 180);
    String content = cleanText(json['content']);

    if (content.isEmpty || content == '[Removed]') {
      content = '';
    }
    String? imageUrl;
    final image = json['urlToImage']?.toString().trim();

    if (image != null &&
        image.isNotEmpty &&
        (image.startsWith('http://') || image.startsWith('https://'))) {
      imageUrl = image;
    }
    String sourceName = '';
    if (json['source'] is Map) {
      sourceName = json['source']['name']?.toString() ?? '';
    }

    if (sourceName.isEmpty) {
      sourceName = 'مصدر غير معروف';
    }

    return NewsServer(
      title: title,
      description: description,
      content: content.isEmpty ? null : content,
      imageUrl: imageUrl,
      url: json['url']?.toString() ?? '',
      publishedAt: json['publishedAt']?.toString() ?? '',
      sourceName: sourceName,
    );
  }
}
