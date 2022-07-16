import 'package:flutter/material.dart';
import 'package:hospital/admin/patient/components/form_mobile.dart';
import 'package:hospital/admin/patient/components/form_tablet.dart';
import 'package:hospital/admin/patient/components/sidebar_patient.dart';
import 'package:hospital/admin/patient/patient_view_model.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class EditPatientScreenAdmin extends StatefulWidget {
  const EditPatientScreenAdmin({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<EditPatientScreenAdmin> createState() => _EditPatientScreenAdminState();
}

class _EditPatientScreenAdminState extends State<EditPatientScreenAdmin> {
  bool result = false;
  late Size size;
  late double height, width;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<PatientViewModel>(context, listen: false);
      await viewModel.getPatientById(widget.id);
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
              SidebarPasien(
                id: widget.id,
                height: height,
                width: width,
                context: context,
                title: 'Edit Data Pasien',
                page: 'Edit',
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      color: const Color(0xffF0F4F9),
                    ),
                    Consumer<PatientViewModel>(
                      builder: (context, value, child) {
                        if (value.state == HospitalState.success) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: width > 915 ? 40 : 20,
                                bottom: width > 915 ? 40 : 20,
                                left: width > 915 ? 30 : 10,
                                right: width > 915 ? 30 : 10,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 7,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(width > 915 ? 50 : 30),
                                child: width > 915
                                    ? FormTabletPatient(
                                        page: 'Edit',
                                        patientViewModel: value,
                                      )
                                    : FormMobilePatient(
                                        page: 'Edit',
                                        patientViewModel: value,
                                      ),
                              ),
                            ),
                          );
                        }

                        if (value.state == HospitalState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
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
            ],
          ),
        ),
      ),
    );
  }
}
