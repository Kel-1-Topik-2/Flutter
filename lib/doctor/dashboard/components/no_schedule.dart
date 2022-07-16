import 'package:flutter/cupertino.dart';

class NoSchedule extends StatelessWidget {
  const NoSchedule({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/Waiting.png',
          scale: 3,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Jadwal pertemuan dengan pasien belum tersedia',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Jadwal pertemuan dengan pasien akan tersedia setelah admin\nmenambahkan jadwal',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        )
      ],
    );
  }
}
