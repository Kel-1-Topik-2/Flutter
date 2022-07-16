import 'package:flutter/material.dart';
import 'package:hospital/admin/patient/components/form_mobile.dart';
import 'package:hospital/admin/patient/components/form_tablet.dart';
import 'package:hospital/admin/patient/components/sidebar_patient.dart';
import 'package:hospital/admin/patient/page/edit_patient_screen.dart';
import 'package:hospital/admin/patient/patient_view_model.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class DetailPatientScreenAdmin extends StatefulWidget {
  const DetailPatientScreenAdmin({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<DetailPatientScreenAdmin> createState() =>
      _DetailPatientScreenAdminState();
}

class _DetailPatientScreenAdminState extends State<DetailPatientScreenAdmin> {
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
                height: height,
                width: width,
                context: context,
                title: 'Detail Data Pasien',
                page: 'Detail',
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 206,
                                      height: 55,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPatientScreenAdmin(
                                                id: widget.id,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(0xff4CA9EE),
                                          minimumSize:
                                              const Size.fromHeight(32),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.edit),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              'EDIT PASIEN',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 70,
                                    ),
                                    width > 915
                                        ? FormTabletPatient(
                                            page: 'Detail',
                                            patientViewModel: value,
                                          )
                                        : FormMobilePatient(
                                            page: 'Detail',
                                            patientViewModel: value,
                                          ),
                                  ],
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
