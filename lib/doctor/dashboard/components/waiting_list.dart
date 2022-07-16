import 'package:flutter/material.dart';
import 'package:hospital/doctor/dashboard/dashboard_doctor_view_model.dart';
import 'package:hospital/doctor/process/process_screen.dart';

class WaitingList extends StatefulWidget {
  const WaitingList({
    Key? key,
    required this.dashboardDoctorviewModel,
    required this.name,
  }) : super(key: key);

  final DashboardDoctorviewModel dashboardDoctorviewModel;
  final String name;

  @override
  State<WaitingList> createState() => _WaitingListState();
}

class _WaitingListState extends State<WaitingList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        itemCount: widget.dashboardDoctorviewModel.scheduleToday.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              card(index),
              button(context, index),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 30,
        ),
      ),
    );
  }

  GestureDetector button(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProcessScreen(
              idPasien:
                  widget.dashboardDoctorviewModel.scheduleToday[index].idPasien,
              idSchedule:
                  widget.dashboardDoctorviewModel.scheduleToday[index].id,
              name: widget.name,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 121,
          right: 121,
          top: 20,
          bottom: 20,
        ),
        width: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          color: const Color(0xff4CA9EE),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 7,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: const Text(
          'Proses Data',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Container card(int index) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
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
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.dashboardDoctorviewModel.scheduleToday[index].namaPasien!,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/Icons (1).png',
                  scale: 3,
                  color: const Color(0xff757575),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.dashboardDoctorviewModel.scheduleToday[index].noUrut
                      .toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/Icons (2).png',
                      scale: 3,
                      color: const Color(0xff757575),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.dashboardDoctorviewModel.scheduleToday[index]
                          .idPasien
                          .toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/Icons (3).png',
                      scale: 3,
                      color: const Color(0xff757575),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.dashboardDoctorviewModel.scheduleToday[index]
                          .jenisPerawatan!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
