import 'package:flutter/material.dart';

class AppbarSchedule extends StatelessWidget {
  const AppbarSchedule({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 210,
          height: 150,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fill,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 70.0),
          child: Text(
            'Tambah Jadwal',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xff358C56),
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
