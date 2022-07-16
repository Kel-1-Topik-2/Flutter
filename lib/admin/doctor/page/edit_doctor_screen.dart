import 'package:flutter/material.dart';
import 'package:hospital/admin/doctor/components/form_mobile.dart';
import 'package:hospital/admin/doctor/components/form_tablet.dart';
import 'package:hospital/admin/doctor/components/sidebar_doctor.dart';
import 'package:hospital/admin/doctor/doctor_view_model.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class EditDoctorScreenAdmin extends StatefulWidget {
  const EditDoctorScreenAdmin({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<EditDoctorScreenAdmin> createState() => _EditDoctorScreenAdminState();
}

class _EditDoctorScreenAdminState extends State<EditDoctorScreenAdmin> {
  bool result = false;
  late Size size;
  late double height, width;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<DoctorViewModel>(context, listen: false);
      await viewModel.getDoctorById(widget.id);
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
              SidebarDoctor(
                height: height,
                width: width,
                context: context,
                title: 'Edit Data Dokter',
                page: 'Edit',
                id: widget.id,
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      color: const Color(0xffF0F4F9),
                    ),
                    Consumer<DoctorViewModel>(
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
                                    ? FormTabletDoctor(
                                        page: 'Edit',
                                        doctorViewModel: value,
                                      )
                                    : FormMobileDoctor(
                                        page: 'Edit',
                                        doctorViewModel: value,
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
