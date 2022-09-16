import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/View/quiz_questionpage.dart';

import '../controller/quiz_category_controller.dart';

class QuizForm extends StatefulWidget {
  const QuizForm({Key? key}) : super(key: key);

  @override
  State<QuizForm> createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  // QuizCategoryModel
  @override
  void initState() {
    super.initState();
    print("initState");

    QuizFormController.to.questionCount.value.text = "10";

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      QuizFormController.to.getQuizCategory();
    });
    QuizFormController.to.quizCategoryModel.refresh();

    print(QuizFormController.to.quizCategoryModel.value.triviaCategories?.first);
  }

  @override
  Widget build(BuildContext context) {
    print(QuizFormController.to.quizCategoryModel.value.triviaCategories?.first);
    QuizFormController.to.quizCategoryModel.refresh();

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz App")),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Obx(
          () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Select Category"),
                    const Spacer(),
                    PopupMenuButton(
                        child: Row(children: [Text(QuizFormController.to.selectedCategoryName.value, overflow: TextOverflow.ellipsis, maxLines: 1), const Icon(Icons.more_vert)]),
                        onSelected: (value) {
                          QuizFormController.to.selectedCategoryId.value = int.parse(value.toString());

                          // print(value.toString());
                          // QuizFormController.to.selectedCategoryId?.value = int.parse(value.toString());
                        },
                        enabled: true,
                        initialValue: QuizFormController.to.quizCategoryModel.value.triviaCategories?.first.id,
                        itemBuilder: (context) {
                          return QuizFormController.to.quizCategoryModel.value.triviaCategories!.map((e) {
                            return PopupMenuItem(
                              value: e.id,
                              onTap: () {
                                QuizFormController.to.selectedCategoryName.value = e.name ?? "";
                                QuizFormController.to.selectedCategoryId.value = e.id ?? 9;
                                QuizFormController.to.selectedCategoryId.refresh();
                                print(QuizFormController.to.selectedCategoryId.value);
                              },
                              child: Text(e.name ?? ""),
                            );
                          }).toList();
                        }),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Text("Select Difficulty"),
                    const Spacer(),
                    PopupMenuButton(
                        child: Row(
                          children: [Text(QuizFormController.to.selectedDifficultyName.value != null ? QuizFormController.to.selectedDifficultyName.value.toUpperCase() : "ANY"), const Icon(Icons.more_vert)],
                        ),
                        onSelected: (value) {
                          print(value.toString());
                          QuizFormController.to.selectedDifficultyName.value = int.parse(value.toString()) == 1
                              ? "easy"
                              : value == 2
                                  ? "medium"
                                  : "hard";
                          print(QuizFormController.to.selectedDifficultyName.value);
                        },
                        enabled: true,
                        // initialValue:1,
                        itemBuilder: (context) {
                          return QuizFormController.to.difficulty.value.map((e) {
                            return PopupMenuItem(
                              value: e == "easy"
                                  ? 1
                                  : e == "medium"
                                      ? 2
                                      : 3,
                              onTap: () {},
                              child: Text(e),
                            );
                          }).toList();
                        }),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GetTextField(
                  hintText: "Enter Question Count",
                  textEditingController: QuizFormController.to.questionCount.value,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Text("Select QuizType"),
                    const Spacer(),
                    PopupMenuButton(
                        child: Row(
                          children: [Text((QuizFormController.to.selectedQuizTypeName == "boolean" ? "True/False" : "Multiple")), const Icon(Icons.more_vert)],
                        ),
                        onSelected: (value) {
                          print(value.toString());
                          // QuizFormController.to.selectedCategoryId.value = int.parse(value.toString());
                        },
                        enabled: true,
                        // initialValue:1,
                        itemBuilder: (context) {
                          return QuizFormController.to.quizType.value.map((e) {
                            return PopupMenuItem(
                              value: e == "boolean" ? 1 : 2,
                              onTap: () {
                                QuizFormController.to.selectedQuizTypeName.value = e;
                                print(QuizFormController.to.selectedQuizTypeName.value);
                              },
                              child: Text(e == "boolean" ? "True/False" : "Multiple"),
                            );
                          }).toList();
                        }),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    var category = QuizFormController.to.selectedCategoryId.value != 000 ? "&category=${QuizFormController.to.selectedCategoryId.value}" : "";
                    var difficulty = QuizFormController.to.selectedDifficultyName.value != "ANY" ? "&difficulty=${QuizFormController.to.selectedDifficultyName.value}" : "";
                    var url = "https://opentdb.com/api.php?amount=${QuizFormController.to.questionCount.value.text.toString()}&type=${QuizFormController.to.selectedQuizTypeName}$category$difficulty";

                    print(url);
                    Get.to(QuizQuestionPage(url: url));
                  },
                  child: const Text(
                    "Go to the Quiz",
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
// QuizFormController.to.

Widget GetTextField({
  String? fieldTitleText,
  required String hintText,
  bool isPassword = false,
  TextEditingController? textEditingController,
  TextInputType? keyboardType,
  TextAlign align = TextAlign.start,
  TextInputAction? inputAction,
  bool? isEnabled,
  int? errorMaxLines,
  int? maxLine,
  FocusNode? textFocusNode,
  GlobalKey<FormFieldState>? key,
  bool isReadOnly = false,
  Widget? suffixIcon,
  Widget? preFixIcon,
  RxBool? showPassword,
  EdgeInsetsGeometry? contentPadding,
  ScrollController? scrollController,
  TextStyle? hintStyle,
  OutlineInputBorder? outlineInputBorder,
  UnderlineInputBorder? underlineInputBorder,
  String? lable,
  TextStyle? lableTextstyle,
}) {
  FocusNode focusNode = FocusNode();
  return StatefulBuilder(
    builder: (context, newSetState) {
      return TextFormField(
        scrollController: scrollController,
        // for scroll extra while keyboard open
        // scrollPadding: EdgeInsets.fromLTRB(20, 20, 20, 120),
        enabled: isEnabled != null && !isEnabled ? false : true,
        textAlign: align,
        showCursor: !isReadOnly,

        key: key,
        focusNode: textFocusNode,

        maxLines: maxLine ?? 1,
        keyboardType: keyboardType,
        controller: textEditingController,
        // initialValue: initialText,
      );
    },
  );
}
