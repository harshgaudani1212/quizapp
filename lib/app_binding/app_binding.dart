import 'package:get/get.dart';

import '../controller/quiz_category_controller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<QuizFormController>(QuizFormController(), permanent: true);
  }
}

