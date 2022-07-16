import 'package:flutter/material.dart';
import 'package:hospital/admin/schedule/components/appbar_schedule.dart';
import 'package:hospital/admin/schedule/components/form_add_schedule.dart';
import 'package:hospital/admin/schedule/components/step_add_schedule.dart';

class AddScheduleScreenAdmin extends StatefulWidget {
  const AddScheduleScreenAdmin({
    Key? key,
    required this.idDokter,
    required this.idPasien,
    required this.namaDokter,
    required this.namaPasien,
  }) : super(key: key);

  final int idPasien, idDokter;
  final String namaPasien, namaDokter;

  @override
  State<AddScheduleScreenAdmin> createState() => _AddScheduleScreenAdminState();
}

class _AddScheduleScreenAdminState extends State<AddScheduleScreenAdmin> {
  late Size size;
  late double height, width;

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
              width: width,
              color: const Color(0xffF0F4F9),
            ),
            SingleChildScrollView(
              child: Container(
                color: const Color(0xffF0F4F9),
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  children: [
                    const AppbarSchedule(),
                    const SizedBox(
                      height: 50,
                    ),
                    const StepAddSchedule(step: 'choose date'),
                    const SizedBox(
                      height: 100,
                    ),
                    FormAddSchedule(
                      idDokter: widget.idDokter,
                      idPasien: widget.idPasien,
                      namaDokter: widget.namaDokter,
                      namaPasien: widget.namaPasien,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
