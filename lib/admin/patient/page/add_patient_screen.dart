import 'package:flutter/material.dart';
import 'package:hospital/admin/patient/components/form_mobile.dart';
import 'package:hospital/admin/patient/components/form_tablet.dart';
import 'package:hospital/admin/patient/components/sidebar_patient.dart';

class AddPatientScreenAdmin extends StatefulWidget {
  const AddPatientScreenAdmin({Key? key}) : super(key: key);

  @override
  State<AddPatientScreenAdmin> createState() => _AddPatientScreenAdminState();
}

class _AddPatientScreenAdminState extends State<AddPatientScreenAdmin> {
  late Size size;
  late double height, width;

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
                title: 'Tambah Data Pasien',
                page: 'Add',
                desc: 'Registrasi Untuk Pasien Baru',
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      color: const Color(0xffF0F4F9),
                    ),
                    SingleChildScrollView(
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
                              ? const FormTabletPatient(
                                  page: 'Add',
                                )
                              : const FormMobilePatient(
                                  page: 'Add',
                                ),
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
}
