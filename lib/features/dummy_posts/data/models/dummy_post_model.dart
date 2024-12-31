// To parse this JSON data, do
//
//     final dummyPostModel = dummyPostModelFromJson(jsonString);

import 'dart:convert';

import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';

DummyPostModel dummyPostModelFromJson(String str) =>
    DummyPostModel.fromJson(json.decode(str));

String dummyPostModelToJson(DummyPostModel data) => json.encode(data.toJson());

class DummyPostModel {
  int id;
  String title;
  String body;
  List<String> tags;
  ReactionsModel reactions;
  int views;
  int userId;

  DummyPostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.reactions,
    required this.views,
    required this.userId,
  });

  factory DummyPostModel.fromJson(Map<String, dynamic> json) => DummyPostModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        reactions: ReactionsModel.fromJson(json["reactions"]),
        views: json["views"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "reactions": reactions.toJson(),
        "views": views,
        "userId": userId,
      };
  DummyPost toEntity() => DummyPost(
      id: id,
      title: title,
      body: body,
      tags: tags,
      reactions: reactions.toEntity(),
      views: views,
      userId: userId,
  );
}

class ReactionsModel {
  int likes;
  int dislikes;

  ReactionsModel({
    required this.likes,
    required this.dislikes,
  });

  factory ReactionsModel.fromJson(Map<String, dynamic> json) => ReactionsModel(
        likes: json["likes"],
        dislikes: json["dislikes"],
      );

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "dislikes": dislikes,
      };
  Reactions toEntity() => Reactions(likes: likes, dislikes: dislikes);
}
