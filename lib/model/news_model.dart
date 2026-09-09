class NewsModel {
  final String title;
  final String description;
  final String? content;
  final String? imageUrl;
  final String url;
  final String publishedAt;
  final String sourceName;

  NewsModel({
    required this.title,
    required this.description,
    this.content,
    this.imageUrl,
    required this.url,
    required this.publishedAt,
    required this.sourceName,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      content: json['content']?.toString(),
      imageUrl: json['image']?.toString(),
      url: json['url']?.toString() ?? '',
      publishedAt: json['publishedAt']?.toString() ?? '',
      sourceName: json['source'] != null && json['source'] is Map
          ? json['source']['name']?.toString() ?? ''
          : '',
    );
  }
}
