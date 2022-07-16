import 'package:flutter/cupertino.dart';
import 'package:hospital/model/api/schedule_api.dart';
import 'package:hospital/model/schedule.dart';
import 'package:hospital/state/hospital_state.dart';

class ReviewViewModel with ChangeNotifier {
  HospitalState _state = HospitalState.loading;
  HospitalState get state => _state;

  Schedule _s = Schedule();

  Schedule get s => _s;

  changeState(HospitalState s) {
    _state = s;
    notifyListeners();
  }

  getReviewById(int id) async {
    changeState(HospitalState.loading);
    try {
      final r = await ScheduleAPI().getScheduleById(id);
      _s = r!;
      notifyListeners();
      changeState(HospitalState.success);
    } catch (e) {
      changeState(HospitalState.error);
    }
  }
}
