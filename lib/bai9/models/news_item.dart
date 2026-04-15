class NewsItem {
  final int id;
  final String title;
  final String body;

  NewsItem({
    required this.id,
    required this.title,
    required this.body,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
