import 'package:dio/dio.dart';
import 'package:quiz_app/model/quiz_category_model.dart';

import 'apiconfig.dart';
const baseUrl = 'https://opentdb.com/';



class APIProvider {
  static Dio dio = Dio();

  static BaseOptions? options = BaseOptions(
      baseUrl: ApiConfig.baseUri,
 
      validateStatus: (code) {
        if (code! >= 200) {
          return true;
        }
        return false;
      });

  static Dio getDio() {
    return dio;
  }
}
