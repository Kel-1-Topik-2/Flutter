import 'package:flutter/material.dart';
import 'package:hospital/admin/archive/archive_screen.dart';
import 'package:hospital/admin/dashboard/dashboard_screen.dart';
import 'package:hospital/admin/doctor/doctor_screen.dart';
import 'package:hospital/admin/patient/patient_screen.dart';
import 'package:hospital/admin/schedule/schedule_screen.dart';
import 'package:hospital/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidebar extends StatefulWidget {
  final String title;
  const Sidebar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late Size size;
  late double height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Center(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: width > 915 ? 40 : 80,
              right: width > 915 ? 40 : 80,
              top: width > 915 ? 70 : 30,
              bottom: width > 915 ? 90 : 30,
            ),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fill,
            ),
          ),
          tile(
            context,
            const DashboardScreen(),
            'assets/images/icon_6.png',
            'Dashboard',
          ),
          tile(
            context,
            const PatientScreenAdmin(),
            'assets/images/icon_5.png',
            'Data Pasien',
          ),
          tile(
            context,
            const DoctorScreenAdmin(),
            'assets/images/icon_9.png',
            'Data Dokter',
          ),
          tile(
            context,
            const ScheduleScreenAdmin(),
            'assets/images/icon_8.png',
            'Kelola Jadwal',
          ),
          tile(
            context,
            const ArchiveScreenAdmin(),
            'assets/images/icon_10.png',
            'Arsip Jadwal',
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              top: 20,
              bottom: 20,
            ),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
          ),
          ListTile(
            visualDensity:
                width > 915 ? null : const VisualDensity(vertical: -4),
            onTap: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
            },
            leading: SizedBox(
              width: width > 915 ? 32 : 20,
              height: width > 915 ? 32 : 20,
              child: Image.asset(
                'assets/images/icon_7.png',
                fit: BoxFit.fill,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: width > 915 ? 18 : 13,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 25),
          )
        ],
      ),
    );
  }

  ListTile tile(
    BuildContext context,
    StatefulWidget page,
    String icon,
    String menu,
  ) {
    return ListTile(
      visualDensity: width > 915 ? null : const VisualDensity(vertical: -4),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      leading: SizedBox(
        width: width > 915 ? 32 : 20,
        height: width > 915 ? 32 : 20,
        child: Image.asset(
          icon,
          fit: BoxFit.fill,
          color: widget.title == menu ? const Color(0xff358C56) : Colors.black,
        ),
      ),
      title: Text(
        menu,
        style: TextStyle(
          fontWeight: widget.title == menu ? FontWeight.w600 : FontWeight.w400,
          fontSize: width > 915 ? 18 : 13,
          fontFamily: 'Poppins',
          color: widget.title == menu ? const Color(0xff358C56) : Colors.black,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 25),
    );
  }
}
