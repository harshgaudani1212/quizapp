// To parse this JSON data, do
//
//     final quizCategoryModel = quizCategoryModelFromJson(jsonString);

import 'dart:convert';

QuizCategoryModel quizCategoryModelFromJson(String str) => QuizCategoryModel.fromJson(json.decode(str));

String quizCategoryModelToJson(QuizCategoryModel data) => json.encode(data.toJson());

class QuizCategoryModel {
  QuizCategoryModel({
    this.triviaCategories,
  });

  List<TriviaCategory>? triviaCategories;

  factory QuizCategoryModel.fromJson(Map<String, dynamic> json) => QuizCategoryModel(
        triviaCategories: json["trivia_categories"] == null ? null : List<TriviaCategory>.from(json["trivia_categories"].map((x) => TriviaCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trivia_categories": triviaCategories == null ? null : List<dynamic>.from(triviaCategories!.map((x) => x.toJson())),
      };
}

class TriviaCategory {
  TriviaCategory({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory TriviaCategory.fromJson(Map<String, dynamic> json) => TriviaCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
