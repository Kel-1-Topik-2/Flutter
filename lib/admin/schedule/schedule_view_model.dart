import 'package:flutter/cupertino.dart';
import 'package:hospital/model/api/schedule_api.dart';
import 'package:hospital/model/schedule.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:intl/intl.dart';

class ScheduleViewModel with ChangeNotifier {
  HospitalState _state = HospitalState.loading;
  HospitalState get state => _state;

  final List<Schedule> _schedules = [];
  List<Schedule> get schedules => _schedules;

  changeState(HospitalState s) {
    _state = s;
    notifyListeners();
  }

  getSchedules() async {
    changeState(HospitalState.loading);
    try {
      _schedules.clear();
      String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final s = await ScheduleAPI().getSchedules();
      for (var i = 0; i < s!.length; i++) {
        if (s[i].tanggal == dateNow &&
            s[i].catatan == null &&
            s[i].diagnosa == null) {
          _schedules.add(s[i]);
        }
      }
      notifyListeners();
      changeState(HospitalState.success);
    } catch (e) {
      changeState(HospitalState.error);
    }
  }

  Future<bool> addSchedule(Schedule schedule) async {
    changeState(HospitalState.loading);
    List<Schedule> cekData = [];

    DateTime konvertDate = DateTime.parse(schedule.tanggal!);
    String konvertDate2 = DateFormat('yyyy-MM-dd').format(konvertDate);

    if (schedules.isNotEmpty) {
      cekData.clear();
      for (int i = 0; i < schedules.length; i++) {
        if (schedules[i].tanggal == konvertDate2) {
          cekData.add(schedules[i]);
        }
      }
    }
    if (cekData.isEmpty) {
      schedule.noUrut = 1;
    } else {
      schedule.noUrut = cekData.last.noUrut! + 1;
    }

    try {
      final s = await ScheduleAPI().addSchedule(schedule);
      changeState(HospitalState.success);
      return s;
    } catch (e) {
      changeState(HospitalState.error);
      return false;
    }
  }
}
