import 'package:flutter/material.dart';
import 'package:hospital/admin/components/sidebar.dart';
import 'package:hospital/admin/dashboard/components/card_dashboard.dart';
import 'package:hospital/admin/dashboard/components/table_dashboard.dart';
import 'package:hospital/admin/dashboard/dashboard_view_model.dart';
import 'package:hospital/admin/schedule/schedule_screen.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Size size;
  late double height, width;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<DashboardViewModel>(context, listen: false);
      await viewModel.getDashboards();
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
            children: [
              const Drawer(
                child: Sidebar(title: 'Dashboard'),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refreshData,
                  child: Consumer<DashboardViewModel>(
                    builder: (context, value, child) {
                      if (value.state == HospitalState.loading) {
                        return Container(
                          color: const Color(0xffF0F4F9),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (value.state == HospitalState.success) {
                        return SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 70,
                              left: 50,
                              right: 50,
                              bottom: 50,
                            ),
                            color: const Color(0xffF0F4F9),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Overview',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: Color(0xff358C56),
                                  ),
                                ),
                                const SizedBox(
                                  height: 48,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: CardDashboard(
                                        width: width,
                                        title: 'Pasien',
                                        count: value.patient,
                                        icon: 'assets/images/icon_card4.png',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 21,
                                    ),
                                    Expanded(
                                      child: CardDashboard(
                                        width: width,
                                        title: 'Dokter',
                                        count: value.doctor,
                                        icon: 'assets/images/icon_card1.png',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: CardDashboard(
                                        width: width,
                                        title: 'Pertemuan Hari Ini',
                                        count: value.schedules.length,
                                        icon: 'assets/images/icon_card3.png',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 120,
                                ),
                                const Text(
                                  'Jadwal Pasien Hari Ini',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: Color(0xff358C56),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ScheduleScreenAdmin(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Lihat Selengkapnya',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff358C56),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableDashboard(
                                  dashboardViewModel: value,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future refreshData() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );
  }
}
