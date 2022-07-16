import 'package:flutter/material.dart';
import 'package:hospital/admin/components/sidebar.dart';
import 'package:hospital/admin/patient/components/table_patient.dart';
import 'package:hospital/admin/patient/patient_view_model.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class PatientScreenAdmin extends StatefulWidget {
  const PatientScreenAdmin({Key? key}) : super(key: key);

  @override
  State<PatientScreenAdmin> createState() => _PatientScreenAdminState();
}

class _PatientScreenAdminState extends State<PatientScreenAdmin> {
  late Size size;
  late double height, width;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<PatientViewModel>(context, listen: false);
      await viewModel.getPatients();
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
                  title: 'Data Pasien',
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
                        child: Consumer<PatientViewModel>(
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
                                child: TablePatient(
                                  patientViewModel: value,
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
        builder: (context) => const PatientScreenAdmin(),
      ),
    );
  }
}
