import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Networking/api_calling.dart';
import 'package:quiz_app/model/quiz_category_model.dart';

import '../model/quiz_question_model.dart';

class QuizFormController extends GetxController {
  static QuizFormController get to => Get.find();

  Rx<int> selectedCategoryId = 000.obs;

  Rx<String> selectedCategoryName = "General Knowledge".obs;
  Rx<String> selectedDifficultyName = "ANY".obs;

  RxList<String> difficulty = ["easy", "medium", "hard"].obs;
  RxList<String> quizType = ["boolean", "multiple"].obs;
  Rx<String> selectedQuizTypeName = "multiple".obs;

  Rx<TextEditingController> questionCount = TextEditingController(text: "10").obs;
  RxString questionCountValue = "10".obs;

  Rx<QuizCategoryModel> quizCategoryModel = QuizCategoryModel().obs;
  Future<QuizCategoryModel> getQuizCategory() async {
    print("called ");
    final quizCategoryData = await APIProvider.getDio().get(baseUrl + 'api_category.php');
    quizCategoryModel.value = quizCategoryModelFromJson(quizCategoryData.toString());
    print(quizCategoryModel.value.toString());
    return quizCategoryModel.value;
  }

  Rx<QuizQuestion> quizQuestionModel = QuizQuestion().obs;

  Future<QuizQuestion> getquizQuestionModel({required String url}) async {
    print("called ");
    final quizQuestionData = await APIProvider.getDio().get(url);
    quizQuestionModel.value = quizQuestionFromJson(quizQuestionData.toString());
    print(quizQuestionModel.value.toString());

    for (int i = 0; i < num.parse((quizQuestionModel.value.results?.length.toString())!); i++) {
      quizQuestionModel.value.results?[i].incorrectAnswers = [quizQuestionModel.value.results?[i].correctAnswer ?? '', ...quizQuestionModel.value.results?[i].incorrectAnswers ?? []];

      quizQuestionModel.value.results?[i].incorrectAnswers?.shuffle();
      print(i);
    }
    return quizQuestionModel.value;
  }
}
