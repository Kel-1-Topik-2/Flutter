import 'package:dio/dio.dart';
import 'package:hospital/model/api/token.dart';
import 'package:hospital/model/doctor.dart';
import 'package:hospital/model/user.dart';

class UserAPI {
  Dio dio = Dio();
  Token token = Token();
  Future<String?> login(User user) async {
    try {
      var result = User.toJson(user);
      final response = await dio.post(
        'https://springboot-postgresql-capstone.herokuapp.com/api/auth/login',
        data: result,
      );
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Doctor?> getDoctor() async {
    try {
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.get(
        'https://springboot-postgresql-capstone.herokuapp.com/dokter/getbydokter',
      );
      if (response.statusCode == 200) {
        Doctor doctors = Doctor.fromJson(response.data['data'][0]);
        return doctors;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
