import 'package:flutter/cupertino.dart';
import 'package:hospital/model/api/schedule_api.dart';
import 'package:hospital/model/schedule.dart';
import 'package:hospital/state/hospital_state.dart';

class ArchiveViewModel with ChangeNotifier {
  HospitalState _state = HospitalState.loading;
  HospitalState get state => _state;

  List<Schedule> _archives = [];
  List<Schedule> get archives => _archives;

  changeState(HospitalState s) {
    _state = s;
    notifyListeners();
  }

  getArchives() async {
    changeState(HospitalState.loading);
    try {
      final a = await ScheduleAPI().getSchedules();
      _archives = a!;
      notifyListeners();
      changeState(HospitalState.success);
    } catch (e) {
      changeState(HospitalState.error);
    }
  }
}
