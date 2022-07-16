import 'package:flutter/material.dart';
import 'package:hospital/admin/components/sidebar.dart';
import 'package:hospital/admin/schedule/components/table_schedule.dart';
import 'package:hospital/admin/schedule/schedule_view_model.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class ScheduleScreenAdmin extends StatefulWidget {
  const ScheduleScreenAdmin({Key? key}) : super(key: key);

  @override
  State<ScheduleScreenAdmin> createState() => _ScheduleScreenAdminState();
}

class _ScheduleScreenAdminState extends State<ScheduleScreenAdmin> {
  late Size size;
  late double height, width;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<ScheduleViewModel>(context, listen: false);
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
        body: SizedBox(
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Drawer(
                child: Sidebar(
                  title: 'Kelola Jadwal',
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      color: const Color(0xffF0F4F9),
                    ),
                    SingleChildScrollView(
                      child: Consumer<ScheduleViewModel>(
                        builder: (context, value, child) {
                          if (HospitalState.loading == value.state) {
                            return Container(
                              height: height,
                              color: const Color(0xffF0F4F9),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          if (HospitalState.success == value.state) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 30,
                                right: 30,
                                top: 90,
                                bottom: 90,
                              ),
                              child: TableSchedule(
                                scheduleViewModel: value,
                              ),
                            );
                          }

                          return Container(
                            height: height,
                            color: const Color(0xffF0F4F9),
                            child: Center(
                              child: Image.asset(
                                'assets/images/notfound.png',
                                scale: 3,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
