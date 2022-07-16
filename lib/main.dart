import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital/admin/archive/archive_view_model.dart';
import 'package:hospital/admin/dashboard/dashboard_view_model.dart';
import 'package:hospital/admin/doctor/doctor_view_model.dart';
import 'package:hospital/admin/patient/patient_view_model.dart';
import 'package:hospital/admin/review/review_view_model.dart';
import 'package:hospital/admin/schedule/schedule_view_model.dart';
import 'package:hospital/doctor/dashboard/dashboard_doctor_view_model.dart';
import 'package:hospital/doctor/process/process_view_model.dart';
import 'package:provider/provider.dart';
import 'login/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => DashboardViewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => PatientViewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => DoctorViewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => ScheduleViewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => ArchiveViewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => ReviewViewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => DashboardDoctorviewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => ProcessViewModel(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: Scaffold(
                body: FutureBuilder(
                  future: Future.delayed(
                    const Duration(seconds: 3),
                  ),
                  builder: (ctx, timer) =>
                      timer.connectionState == ConnectionState.done
                          ? const LoginScreen()
                          : Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
