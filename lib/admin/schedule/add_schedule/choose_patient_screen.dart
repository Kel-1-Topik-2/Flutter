import 'package:flutter/material.dart';
import 'package:hospital/admin/schedule/components/appbar_schedule.dart';
import 'package:hospital/admin/schedule/components/step_add_schedule.dart';
import 'package:hospital/admin/schedule/components/table_choose_patient.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';
import 'package:hospital/admin/patient/patient_view_model.dart';

class ChoosePatientScreenAdmin extends StatefulWidget {
  const ChoosePatientScreenAdmin({Key? key}) : super(key: key);

  @override
  State<ChoosePatientScreenAdmin> createState() =>
      _ChoosePatientScreenAdminState();
}

class _ChoosePatientScreenAdminState extends State<ChoosePatientScreenAdmin> {
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
        body: Stack(
          children: [
            Container(
              height: height,
              color: const Color(0xffF0F4F9),
            ),
            RefreshIndicator(
              onRefresh: refreshData,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(60.0),
                  child: Column(
                    children: [
                      const AppbarSchedule(),
                      const SizedBox(
                        height: 50,
                      ),
                      const StepAddSchedule(
                        step: 'choose pasien',
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Consumer<PatientViewModel>(
                        builder: (context, value, child) {
                          if (HospitalState.loading == value.state) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (HospitalState.success == value.state) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 50,
                                right: 50,
                              ),
                              child: TableChoosePatient(
                                patientViewModel: value,
                              ),
                            );
                          }

                          return Center(
                            child: Image.asset(
                              'assets/images/notfound.png',
                              scale: 3,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future refreshData() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ChoosePatientScreenAdmin(),
      ),
    );
  }
}
