// To parse this JSON data, do
//
//     final dummyPostTagModel = dummyPostTagModelFromJson(jsonString);

import 'dart:convert';

import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post_tag.dart';

DummyPostTagModel dummyPostTagModelFromJson(String str) =>
    DummyPostTagModel.fromJson(json.decode(str));

String dummyPostTagModelToJson(DummyPostTagModel data) =>
    json.encode(data.toJson());

class DummyPostTagModel {
  String slug;
  String name;
  String url;

  DummyPostTagModel({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory DummyPostTagModel.fromJson(Map<String, dynamic> json) =>
      DummyPostTagModel(
        slug: json["slug"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "url": url,
      };
  DummyPostTag toEntity() => DummyPostTag(slug: slug, name: name, url: url);
}
