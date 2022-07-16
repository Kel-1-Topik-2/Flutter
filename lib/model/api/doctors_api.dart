import 'package:dio/dio.dart';
import 'package:hospital/model/api/token.dart';
import 'package:hospital/model/doctor.dart';

class DoctorAPI {
  Dio dio = Dio();
  Token token = Token();
  Future<List<Doctor>?> getDoctors() async {
    try {
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.get(
        'https://springboot-postgresql-capstone.herokuapp.com/dokter',
      );
      if (response.statusCode == 200) {
        List<Doctor> doctors = (response.data as List)
            .map(
              (e) => Doctor.fromJson(e),
            )
            .toList();
        return doctors;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Doctor?> getDoctorById(int id) async {
    try {
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.get(
        'https://springboot-postgresql-capstone.herokuapp.com/dokter/$id',
      );
      if (response.statusCode == 200) {
        Doctor doctors = Doctor.fromJson(response.data['data']);
        return doctors;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> addDoctor(Doctor doctor) async {
    try {
      var user = Doctor.toJsonUser(doctor);
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response1 = await dio.post(
        'https://springboot-postgresql-capstone.herokuapp.com/api/auth/register',
        data: user,
      );

      if (response1.statusCode == 200) {
        var dokter = Doctor.toJsonDokter(doctor, response1.data['data']['id']);
        final response2 = await dio.post(
          'https://springboot-postgresql-capstone.herokuapp.com/dokter',
          data: dokter,
        );

        if (response2.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> editDoctor(Doctor doctor) async {
    try {
      var user = Doctor.toJsonUser(doctor);
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response1 = await dio.put(
        'https://springboot-postgresql-capstone.herokuapp.com/user/${doctor.idUsername}',
        data: user,
      );
      if (response1.statusCode == 200) {
        var dokter = Doctor.toJsonDokter(doctor, doctor.idUsername!);
        final response2 = await dio.put(
          'https://springboot-postgresql-capstone.herokuapp.com/dokter/${doctor.id}',
          data: dokter,
        );

        if (response2.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteDoctor(int id, int idUsername) async {
    try {
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response1 = await dio.delete(
        'https://springboot-postgresql-capstone.herokuapp.com/user/$idUsername',
      );
      if (response1.statusCode == 200) {
        await token.tokenFunc();
        dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
        final response2 = await dio.delete(
          'https://springboot-postgresql-capstone.herokuapp.com/dokter/$id',
        );

        if (response2.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
