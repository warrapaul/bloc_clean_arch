class Article {
  Source source;
  String? author;
  String title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
}

class Source {
  dynamic id;
  String name;

  Source({
    required this.id,
    required this.name,
  });
}
