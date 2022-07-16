import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hospital/model/api/user_api.dart';
import 'package:hospital/model/doctor.dart';
import 'package:hospital/model/user.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  HospitalState _state = HospitalState.success;
  HospitalState get state => _state;

  changeState(HospitalState s) {
    _state = s;
    notifyListeners();
  }

  login(User user, String role, bool check) async {
    changeState(HospitalState.loading);
    try {
      final token = await UserAPI().login(user);
      if (token!.isNotEmpty == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        if (role == 'Doctor') {
          final d = await UserAPI().getDoctor();
          await prefs.setString('doctor', jsonEncode(Doctor.toJson(d!)));
        }
        if (check == true) {
          await prefs.setString('login', jsonEncode(User.toJson(user)));
          changeState(HospitalState.success);
        }
        changeState(HospitalState.success);
      } else {
        changeState(HospitalState.error);
      }
    } catch (e) {
      changeState(HospitalState.error);
    }
  }
}
