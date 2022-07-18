import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hospital/doctor/dashboard/components/dashboard_error.dart';
import 'package:hospital/doctor/dashboard/components/no_schedule.dart';
import 'package:hospital/doctor/dashboard/components/table_dashboard_doctor.dart';
import 'package:hospital/doctor/dashboard/components/waiting_list.dart';
import 'package:hospital/doctor/dashboard/dashboard_doctor_view_model.dart';
import 'package:hospital/doctor/dashboard/schedule_all_screen.dart';
import 'package:hospital/doctor/components/appbar.dart';
import 'package:hospital/model/doctor.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreenDoctor extends StatefulWidget {
  const DashboardScreenDoctor({Key? key}) : super(key: key);

  @override
  State<DashboardScreenDoctor> createState() => _DashboardScreenDoctorState();
}

class _DashboardScreenDoctorState extends State<DashboardScreenDoctor> {
  Doctor doctor = Doctor();
  late Size size;
  late double height, width;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<DashboardDoctorviewModel>(
        context,
        listen: false,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var cek = prefs.getString('doctor');
      doctor = Doctor.fromJson2(jsonDecode(cek!));
      await viewModel.getSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    final contextProvider = Provider.of<DashboardDoctorviewModel>(context);
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: const Color(0xffF0F4F9),
            ),
            Column(
              children: [
                Consumer<DashboardDoctorviewModel>(
                  builder: (context, value, child) {
                    if (value.state == HospitalState.loading) {
                      return const Appbar(
                        name: '',
                      );
                    }
                    if (value.state == HospitalState.success) {
                      return Appbar(
                        name: doctor.namaLengkap != null
                            ? doctor.namaLengkap!
                            : 'null',
                      );
                    }

                    return const Appbar(
                      name: 'null',
                    );
                  },
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: refreshData,
                    child: ListView(
                      padding: const EdgeInsets.only(
                        left: 50,
                        right: 50,
                        top: 50,
                        bottom: 50,
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pertemuan Hari Ini',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff358C56),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(DateTime.now())
                                      .toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff358C56),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (contextProvider.state ==
                                    HospitalState.success)
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ScheduleAllScreen(
                                            name: doctor.namaLengkap!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Lihat Selengkapnya',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        color: Color(0xff358C56),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Consumer<DashboardDoctorviewModel>(
                          builder: (context, value, child) {
                            if (value.state == HospitalState.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (value.state == HospitalState.success) {
                              if (value.scheduleToday.isNotEmpty) {
                                return WaitingList(
                                  dashboardDoctorviewModel: value,
                                  name: doctor.namaLengkap != null
                                      ? doctor.namaLengkap!
                                      : 'null',
                                );
                              } else {
                                return const NoSchedule();
                              }
                            }

                            return const DashboardError();
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Histori Data Pertemuan Pasien',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff358C56),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Consumer<DashboardDoctorviewModel>(
                          builder: (context, value, child) {
                            if (value.state == HospitalState.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (value.state == HospitalState.success) {
                              return TableDashboardDoctor(
                                dashboardDoctorviewModel: value,
                                name: doctor.namaLengkap != null
                                    ? doctor.namaLengkap!
                                    : 'null',
                              );
                            }

                            return const DashboardError();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future refreshData() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreenDoctor(),
      ),
    );
  }
}
