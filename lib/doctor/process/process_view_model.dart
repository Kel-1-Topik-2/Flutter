import 'package:flutter/cupertino.dart';
import 'package:hospital/admin/schedule/schedule_view_model.dart';
import 'package:hospital/model/api/patient_api.dart';
import 'package:hospital/model/patient.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:intl/intl.dart';
import 'package:hospital/model/api/schedule_api.dart';
import 'package:hospital/model/schedule.dart';

class ProcessViewModel with ChangeNotifier {
  HospitalState _state = HospitalState.loading;
  HospitalState get state => _state;

  Patient _p = Patient();
  Patient get p => _p;

  Schedule _s = Schedule();
  Schedule get s => _s;

  changeState(HospitalState s) {
    _state = s;
    notifyListeners();
  }

  getPatientById(int idPasien, int idSchedule) async {
    changeState(HospitalState.loading);
    try {
      final p = await PatientAPI().getPatientById(idPasien);
      final s = await ScheduleAPI().getScheduleById(idSchedule);
      _p = p!;
      _s = s!;
      notifyListeners();
      changeState(HospitalState.success);
    } catch (e) {
      changeState(HospitalState.error);
    }
  }

  Future<bool> prosesPasien(Schedule schedule) async {
    try {
      final p = await ScheduleAPI().editSchedule(schedule);
      return p;
    } catch (e) {
      return false;
    }
  }

  Future<bool> prosesPasienRawatJalan(Schedule schedule) async {
    try {
      bool p;
      ScheduleViewModel scheduleViewModel = ScheduleViewModel();
      List<Schedule> cekData = [];

      if (schedule.tanggal!.isNotEmpty && schedule.controll!.isNotEmpty) {
        DateTime konvertDate = DateTime.parse(schedule.tanggal!);
        String konvertDate2 = DateFormat('yyyy-MM-dd').format(konvertDate);
        if (scheduleViewModel.schedules.isNotEmpty) {
          cekData.clear();
          for (int i = 0; i < scheduleViewModel.schedules.length; i++) {
            if (scheduleViewModel.schedules[i].tanggal == konvertDate2) {
              cekData.add(scheduleViewModel.schedules[i]);
            }
          }
        }
        if (cekData.isEmpty) {
          schedule.noUrut = 1;
        } else {
          if (cekData.last.noUrut != null) {
            schedule.noUrut = cekData.last.noUrut! + 1;
          }
        }
        p = await ScheduleAPI().editSchedule(schedule);
        p = await ScheduleAPI().addSchedule(schedule);
      } else {
        p = await ScheduleAPI().editSchedule(schedule);
      }
      return p;
    } catch (e) {
      return false;
    }
  }
}
