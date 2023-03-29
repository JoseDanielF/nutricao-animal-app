import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';

class EditAnimalRepository {
  late int userId;
  late String userToken;

  Future<bool> patchAnimal(nome, sex, castrated, peso, altura, specie) async {
    Dio dio = Dio();

    final prefs = await SharedPreferences.getInstance();

    userId = prefs.getInt('id')!;
    userToken = prefs.getString('token')!;

    var response = await dio.patch(
      '$kBaseUrl/users/$userId',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      ),
      data: {
        "name": nome.toString(),
        "sex": sex.toString(),
        "is_castrated": castrated.toString(),
        'activity_level': '',
        "weight": peso.toString(),
        "height": altura.toString(),
        "breed_id": specie.toString(),
        "image": '',
      },
    );
    if (kDebugMode) {
      print(response.statusCode);
    }
    return response.statusCode == 200 || response.statusCode == 201
        ? true
        : false;
  }
}
