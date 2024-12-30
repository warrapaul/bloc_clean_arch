import 'dart:convert';

import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';

ArticleModel articleModelFromJson(String str) =>
    ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  SourceModel source;
  String? author;
  String title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  ArticleModel({
    required this.source,
    this.author,
    required this.title,
    this.description,
    this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        source: SourceModel.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };

  // Map Model to Entity
  Article toEntity() => Article(
        source: source.toEntity(), 
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content,
      );
}

class SourceModel {
  dynamic id;
  String name;

  SourceModel({
    required this.id,
    required this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

       Source toEntity() => Source(
        id: id,
        name: name,
      );
}
