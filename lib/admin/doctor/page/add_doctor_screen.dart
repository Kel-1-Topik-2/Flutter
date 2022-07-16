import 'package:flutter/material.dart';
import 'package:hospital/admin/doctor/components/form_mobile.dart';
import 'package:hospital/admin/doctor/components/form_tablet.dart';
import 'package:hospital/admin/doctor/components/sidebar_doctor.dart';

class AddDoctorScreenAdmin extends StatefulWidget {
  const AddDoctorScreenAdmin({Key? key}) : super(key: key);

  @override
  State<AddDoctorScreenAdmin> createState() => _AddDoctorScreenAdminState();
}

class _AddDoctorScreenAdminState extends State<AddDoctorScreenAdmin> {
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
              SidebarDoctor(
                height: height,
                width: width,
                context: context,
                title: 'Tambah Data Dokter',
                page: 'Add',
                desc: 'Resgistrasi untuk dokter baru.',
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
                              ? const FormTabletDoctor(
                                  page: 'Add',
                                )
                              : const FormMobileDoctor(
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
