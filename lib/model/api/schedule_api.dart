import 'package:dio/dio.dart';
import 'package:hospital/model/api/token.dart';
import 'package:hospital/model/schedule.dart';

class ScheduleAPI {
  Dio dio = Dio();
  Token token = Token();
  Future<List<Schedule>?> getSchedules() async {
    try {
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.get(
        'https://springboot-postgresql-capstone.herokuapp.com/jadwal',
      );
      if (response.statusCode == 200) {
        List<Schedule> schedules = (response.data as List)
            .map(
              (e) => Schedule.fromJson(e),
            )
            .toList();
        return schedules;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Schedule?> getScheduleById(int id) async {
    try {
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.get(
        'https://springboot-postgresql-capstone.herokuapp.com/jadwal/$id',
      );
      if (response.statusCode == 200) {
        Schedule schedules = Schedule.fromJson(response.data['data']);
        return schedules;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> addSchedule(Schedule schedule) async {
    try {
      var result = Schedule.toJson(schedule);
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.post(
        'https://springboot-postgresql-capstone.herokuapp.com/jadwal',
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

  Future<bool> editSchedule(Schedule schedule) async {
    try {
      var result = Schedule.toJson2(schedule);
      await token.tokenFunc();
      dio.options.headers['Authorization'] = 'Bearer: ${token.token}';
      final response = await dio.put(
        'https://springboot-postgresql-capstone.herokuapp.com/jadwal/editbydokter/${schedule.id}',
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
}
