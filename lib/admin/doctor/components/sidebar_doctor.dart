import 'package:flutter/material.dart';
import 'package:hospital/admin/doctor/doctor_screen.dart';
import 'package:hospital/admin/doctor/page/detail_doctor_screen.dart';

class SidebarDoctor extends StatelessWidget {
  const SidebarDoctor({
    Key? key,
    this.id,
    required this.height,
    required this.width,
    required this.context,
    required this.title,
    required this.page,
    this.desc,
  }) : super(key: key);

  final int? id;
  final double height;
  final double width;
  final BuildContext context;
  final String title;
  final String page;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/left_bg_form_doctor.png',
            ),
            Container(
              height: height,
              padding: EdgeInsets.all(width > 915 ? 35 : 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      if (page == 'Edit') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailDoctorScreenAdmin(
                              id: id!,
                            ),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoctorScreenAdmin(),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: width > 915 ? 50 : 35,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: width > 915 ? 48 : 25,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      if (desc != null)
                        Text(
                          desc!,
                          style: TextStyle(
                            fontSize: width > 915 ? 20 : 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      SizedBox(
                        height: width > 915 ? 15 : 25,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
