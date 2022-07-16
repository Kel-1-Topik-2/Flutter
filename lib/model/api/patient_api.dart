import 'package:dio/dio.dart';
import 'package:hospital/model/api/token.dart';
import 'package:hospital/model/patient.dart';

class PatientAPI {
  Dio dio = Dio();
  Token token = Token();
  Future<List<Patient>?> getPatients() async {
    try {
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.get(
        'https://springboot-postgresql-capstone.herokuapp.com/pasien',
      );
      if (response.statusCode == 200) {
        List<Patient> patients = (response.data as List)
            .map(
              (e) => Patient.fromJson(e),
            )
            .toList();
        return patients;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> addPatient(Patient patient) async {
    try {
      var result = Patient.toJson(patient);
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.post(
        'https://springboot-postgresql-capstone.herokuapp.com/pasien',
        data: result,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> editPatient(Patient patient) async {
    try {
      var result = Patient.toJson(patient);
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.put(
        "https://springboot-postgresql-capstone.herokuapp.com/pasien/${patient.id}",
        data: result,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Patient?> getPatientById(int id) async {
    try {
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.get(
        'https://springboot-postgresql-capstone.herokuapp.com/pasien/$id',
      );
      if (response.statusCode == 200) {
        Patient patients = Patient.fromJson(response.data['data']);
        return patients;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> deletePatient(int id) async {
    try {
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.delete(
        'https://springboot-postgresql-capstone.herokuapp.com/pasien/$id',
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
