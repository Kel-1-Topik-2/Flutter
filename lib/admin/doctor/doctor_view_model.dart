import 'package:flutter/cupertino.dart';
import 'package:hospital/model/api/doctors_api.dart';
import 'package:hospital/model/doctor.dart';
import 'package:hospital/state/hospital_state.dart';

class DoctorViewModel with ChangeNotifier {
  HospitalState _state = HospitalState.success;
  HospitalState get state => _state;

  List<Doctor> _doctor = [];
  List<Doctor> get doctors => _doctor;

  Doctor _d = Doctor();
  Doctor get d => _d;

  changeState(HospitalState s) {
    _state = s;
    notifyListeners();
  }

  getDoctors() async {
    changeState(HospitalState.loading);
    try {
      final d = await DoctorAPI().getDoctors();
      _doctor = d!;
      notifyListeners();
      changeState(HospitalState.success);
    } catch (e) {
      changeState(HospitalState.error);
    }
  }

  getDoctorById(int id) async {
    changeState(HospitalState.loading);
    try {
      final d = await DoctorAPI().getDoctorById(id);
      _d = d!;
      notifyListeners();
      changeState(HospitalState.success);
    } catch (e) {
      changeState(HospitalState.error);
    }
  }

  Future<bool> addDoctor(Doctor doctor) async {
    changeState(HospitalState.loading);
    try {
      final d = await DoctorAPI().addDoctor(doctor);
      changeState(HospitalState.success);
      return d;
    } catch (e) {
      changeState(HospitalState.error);
      return false;
    }
  }

  Future<bool> editDoctor(Doctor doctor) async {
    try {
      final p = await DoctorAPI().editDoctor(doctor);
      return p;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteDoctor(int id, int idUsername) async {
    changeState(HospitalState.loading);
    try {
      final p = await DoctorAPI().deleteDoctor(id, idUsername);
      await getDoctors();
      changeState(HospitalState.success);
      return p;
    } catch (e) {
      changeState(HospitalState.error);
      return false;
    }
  }
}
