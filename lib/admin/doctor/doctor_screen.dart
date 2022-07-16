import 'package:flutter/material.dart';
import 'package:hospital/admin/components/sidebar.dart';
import 'package:hospital/admin/doctor/components/table_doctor.dart';
import 'package:hospital/admin/doctor/doctor_view_model.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class DoctorScreenAdmin extends StatefulWidget {
  const DoctorScreenAdmin({Key? key}) : super(key: key);

  @override
  State<DoctorScreenAdmin> createState() => _DoctorScreenAdminState();
}

class _DoctorScreenAdminState extends State<DoctorScreenAdmin> {
  late Size size;
  late double height, width;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<DoctorViewModel>(context, listen: false);
      await viewModel.getDoctors();
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
                  title: 'Data Dokter',
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      color: const Color(0xffF0F4F9),
                    ),
                    RefreshIndicator(
                      onRefresh: refreshData,
                      child: SingleChildScrollView(
                        child: Consumer<DoctorViewModel>(
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
                                child: TableDoctor(
                                  doctorViewModel: value,
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

  Future refreshData() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DoctorScreenAdmin(),
      ),
    );
  }
}
