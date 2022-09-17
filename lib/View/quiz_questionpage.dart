import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quiz_category_controller.dart';
import '../model/quiz_question_model.dart';

class QuizQuestionPage extends StatefulWidget {
  final String url;
  const QuizQuestionPage({Key? key, required this.url}) : super(key: key);

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  RxList<bool>? questionAttemptedList = List.filled(int.parse(QuizFormController.to.questionCount.value.text.toString()), false).obs;
  RxList<bool>? questionCorrectList = List.filled(int.parse(QuizFormController.to.questionCount.value.text.toString()), false).obs;

  Rx<int> questionAttemptedCount = 0.obs;
  Rx<int> questionCorrectCount = 0.obs;
  RxList<int>? attemptedOptionList = List.filled(int.parse(QuizFormController.to.questionCount.value.text.toString()), 99).obs;

  List<List<String>>? options;

  @override
  void initState() {
    super.initState();
    print(widget.url);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      QuizFormController.to.quizQuestionModel.value = QuizQuestion();
      QuizFormController.to.getquizQuestionModel(url: widget.url);
      print("initState");
      print(questionAttemptedList?.length);
    });
  }

  @override
  void dispose() {
    questionAttemptedList?.clear();
    questionCorrectList?.clear();
    questionAttemptedCount.value = 0;
    questionCorrectCount.value = 0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Questions")),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  color: Colors.blue,
                  height: 28,
                  child: Center(
                    child: Text(
                      "Current Score ${questionCorrectCount.value}/${questionAttemptedCount.value}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            Expanded(
              child: QuizFormController.to.quizQuestionModel.value.results?[0].question == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: QuizFormController.to.quizQuestionModel.value.results?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(child: Text("(${index + 1}). ${QuizFormController.to.quizQuestionModel.value.results?[index].question ?? "Loading...."}")),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Options"),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                // height: 250,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: (QuizFormController.to.quizQuestionModel.value.results?[index].incorrectAnswers?.length ?? 1),
                                  itemBuilder: (context, indexx) {
                                    RxString tempString = ''.obs;

                                    print(QuizFormController.to.quizQuestionModel.value.results?[index].incorrectAnswers?.length);
                                    return QuizFormController.to.quizQuestionModel.value.results?[index].incorrectAnswers == null
                                        ? const Text("Loading....")
                                        : Obx(
                                            () => Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: ListTile(
                                                title: Text(QuizFormController.to.quizQuestionModel.value.results?[index].incorrectAnswers?[indexx] ?? ''),
                                                tileColor: questionAttemptedList?[index] == true
                                                    ? ((QuizFormController.to.quizQuestionModel.value.results?[index].incorrectAnswers?[indexx] ?? "") == (QuizFormController.to.quizQuestionModel.value.results?[index].correctAnswer))
                                                        ? Colors.green
                                                        : tempString.value == (QuizFormController.to.quizQuestionModel.value.results?[index].incorrectAnswers?[indexx] ?? '')
                                                            ? Colors.white
                                                            : (attemptedOptionList?[index] ?? 0) == indexx
                                                                ? Colors.red
                                                                : Colors.white
                                                    : Colors.white,
                                                onTap: () {
                                                  if (questionAttemptedList?[index] == false) {
                                                    attemptedOptionList?[index] = indexx;
                                                    tempString.value = QuizFormController.to.quizQuestionModel.value.results?[index].incorrectAnswers?[indexx] ?? '';

                                                    questionAttemptedCount.value = questionAttemptedCount.value + 1;
                                                    questionAttemptedList?[index] = true;
                                                    if (((QuizFormController.to.quizQuestionModel.value.results?[index].incorrectAnswers?[indexx] ?? "") == (QuizFormController.to.quizQuestionModel.value.results?[index].correctAnswer)) && (questionAttemptedList?[index] == true)) {
                                                      if (questionCorrectList?[index] == false) {
                                                        questionCorrectCount.value = questionCorrectCount.value + 1;
                                                        questionCorrectList?[index] = true;
                                                      } else {
                                                        questionCorrectCount.value = questionCorrectCount.value - 1;
                                                        questionCorrectList?[index] = false;
                                                      }
                                                    }
                                                  } else {
                                                    //
                                                  }
                                                },
                                              ),
                                            ),
                                          );
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      title: const Text("Quit Quiz"),
                      content: Text("Your overall score ${questionCorrectCount.value} out of ${QuizFormController.to.quizQuestionModel.value.results?.length ?? 0}."),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Get.back();
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: const Text("OKAY"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Quit Quiz",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}