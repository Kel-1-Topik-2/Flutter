import 'package:flutter/cupertino.dart';
import 'package:hospital/model/api/patient_api.dart';
import 'package:hospital/model/patient.dart';
import 'package:hospital/state/hospital_state.dart';

class PatientViewModel with ChangeNotifier {
  HospitalState _state = HospitalState.success;
  HospitalState get state => _state;

  List<Patient> _patient = [];
  List<Patient> get patients => _patient;

  Patient _p = Patient();
  Patient get p => _p;

  changeState(HospitalState s) {
    _state = s;
    notifyListeners();
  }

  getPatients() async {
    changeState(HospitalState.loading);
    try {
      final p = await PatientAPI().getPatients();
      _patient = p!;
      notifyListeners();
      changeState(HospitalState.success);
    } catch (e) {
      changeState(HospitalState.error);
    }
  }

  getPatientById(int id) async {
    changeState(HospitalState.loading);
    try {
      final p = await PatientAPI().getPatientById(id);
      _p = p!;
      notifyListeners();
      changeState(HospitalState.success);
    } catch (e) {
      changeState(HospitalState.error);
    }
  }

  Future<bool> addPatient(Patient patient) async {
    changeState(HospitalState.loading);
    try {
      final p = await PatientAPI().addPatient(patient);
      changeState(HospitalState.success);
      return p;
    } catch (e) {
      changeState(HospitalState.error);
      return false;
    }
  }

  Future<bool> editPatient(Patient patient) async {
    try {
      final p = await PatientAPI().editPatient(patient);
      return p;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePatient(int id) async {
    changeState(HospitalState.loading);
    try {
      final p = await PatientAPI().deletePatient(id);
      await getPatients();
      changeState(HospitalState.success);
      return p;
    } catch (e) {
      changeState(HospitalState.error);
      return false;
    }
  }
}
