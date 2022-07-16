import 'package:flutter/material.dart';
import 'package:hospital/doctor/components/appbar.dart';
import 'package:hospital/doctor/dashboard/components/table_schedule_all.dart';
import 'package:hospital/doctor/dashboard/dashboard_screen_doctor.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dashboard_doctor_view_model.dart';

class ScheduleAllScreen extends StatefulWidget {
  const ScheduleAllScreen({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  State<ScheduleAllScreen> createState() => _ScheduleAllScreenState();
}

class _ScheduleAllScreenState extends State<ScheduleAllScreen> {
  late Size size;
  late double height, width;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel =
          Provider.of<DashboardDoctorviewModel>(context, listen: false);
      await viewModel.getSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Appbar(name: widget.name),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: refreshData,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 50,
                            top: 50,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DashboardScreenDoctor(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    size: 45,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Pertemuan Hari Ini',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
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
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Consumer<DashboardDoctorviewModel>(
                                      builder: (context, value, child) {
                                        if (value.state ==
                                            HospitalState.loading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (value.state ==
                                            HospitalState.success) {
                                          return TableScheduleAll(
                                            dashboardDoctorviewModel: value,
                                            name: widget.name,
                                          );
                                        }

                                        return const Center(
                                          child: Text('Data Tidak Ditemukan'),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
        builder: (context) => ScheduleAllScreen(
          name: widget.name,
        ),
      ),
    );
  }
}
