import 'package:flutter/cupertino.dart';
import 'package:hospital/model/api/schedule_api.dart';
import 'package:hospital/model/schedule.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:intl/intl.dart';

class DashboardDoctorviewModel with ChangeNotifier {
  HospitalState _state = HospitalState.loading;
  HospitalState get state => _state;

  final List<Schedule> _scheduleToday = [];
  List<Schedule> get scheduleToday => _scheduleToday;

  final List<Schedule> _historySchedule = [];
  List<Schedule> get historySchedule => _historySchedule;

  changeState(HospitalState s) {
    _state = s;
    notifyListeners();
  }

  getSchedules() async {
    changeState(HospitalState.loading);
    try {
      _scheduleToday.clear();
      _historySchedule.clear();
      String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final s = await ScheduleAPI().getSchedules();
      for (var i = 0; i < s!.length; i++) {
        if (s[i].tanggal == dateNow &&
            s[i].catatan == null &&
            s[i].diagnosa == null) {
          _scheduleToday.add(s[i]);
        }
        if (s[i].catatan != null && s[i].diagnosa != null) {
          _historySchedule.add(s[i]);
        }
      }
      notifyListeners();
      changeState(HospitalState.success);
    } catch (e) {
      changeState(HospitalState.error);
    }
  }
}
