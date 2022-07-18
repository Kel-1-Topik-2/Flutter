import 'package:flutter/cupertino.dart';
import 'package:hospital/model/api/doctors_api.dart';
import 'package:hospital/model/api/patient_api.dart';
import 'package:hospital/model/api/schedule_api.dart';
import 'package:hospital/model/schedule.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:intl/intl.dart';

class DashboardViewModel with ChangeNotifier {
  HospitalState _state = HospitalState.success;
  HospitalState get state => _state;

  final List<Schedule> _schedule = [];
  List<Schedule> get schedules => _schedule;

  int patient = 0;
  int doctor = 0;

  changeState(HospitalState s) {
    _state = s;
    notifyListeners();
  }

  getDashboards() async {
    changeState(HospitalState.loading);
    try {
      _schedule.clear();
      patient = 0;
      doctor = 0;

      final p = await PatientAPI().getPatients();
      final d = await DoctorAPI().getDoctors();
      final s = await ScheduleAPI().getSchedules();

      if (p != null) {
        patient = p.length;
      }
      if (d != null) {
        doctor = d.length;
      }
      if (s != null) {
        for (var i = 0; i < s.length; i++) {
          if (s[i].tanggal == DateFormat('yyyy-MM-dd').format(DateTime.now()) &&
              s[i].catatan == null &&
              s[i].diagnosa == null) {
            _schedule.add(s[i]);
          }
        }
      }
      notifyListeners();
      changeState(HospitalState.success);
    } catch (e) {
      changeState(HospitalState.error);
    }
  }
}
