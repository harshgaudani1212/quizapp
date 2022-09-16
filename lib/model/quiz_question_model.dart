// To parse this JSON data, do
//
//     final quizQuestion = quizQuestionFromJson(jsonString);

import 'dart:convert';

QuizQuestion quizQuestionFromJson(String str) => QuizQuestion.fromJson(json.decode(str));

String quizQuestionToJson(QuizQuestion data) => json.encode(data.toJson());

class QuizQuestion {
  QuizQuestion({
    this.responseCode,
    this.results,
  });

  int? responseCode;
  List<Result>? results;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
        responseCode: json["response_code"],
        results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
  });

  Category? category;
  Type? type;
  Difficulty? difficulty;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        category: json["category"] == null ? null : categoryValues.map[json["category"]],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        difficulty: json["difficulty"] == null ? null : difficultyValues.map[json["difficulty"]],
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers: json["incorrect_answers"] == null ? null : List<String>.from(json["incorrect_answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": category == null ? null : categoryValues.reverse[category],
        "type": type == null ? null : typeValues.reverse[type],
        "difficulty": difficulty == null ? null : difficultyValues.reverse[difficulty],
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers": incorrectAnswers == null ? null : List<dynamic>.from(incorrectAnswers!.map((x) => x)),
      };
}

enum Category { GENERAL_KNOWLEDGE }

final categoryValues = EnumValues({"General Knowledge": Category.GENERAL_KNOWLEDGE});

enum Difficulty { EASY }

final difficultyValues = EnumValues({"easy": Difficulty.EASY});

enum Type { MULTIPLE }

final typeValues = EnumValues({"multiple": Type.MULTIPLE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap ?? {};
  }
}
