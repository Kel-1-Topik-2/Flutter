import 'package:flutter/material.dart';

class StepAddSchedule extends StatelessWidget {
  const StepAddSchedule({
    Key? key,
    required this.step,
  }) : super(key: key);

  final String step;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 200,
        right: 200,
      ),
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xff4CA9EE),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xffF0F4F9),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/images/icon_card4.png',
                      color: const Color(0xff4CA9EE),
                    ),
                  ),
                ),
              ),
              const Text(
                '1. Pilih Pasien',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xff4CA9EE),
                ),
              ),
            ],
          ),
          Expanded(
            child: Divider(
              thickness: 2,
              color: step == 'choose dokter' || step == 'choose date'
                  ? const Color(0xff4CA9EE)
                  : const Color(0xff757575),
            ),
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    step == 'choose dokter' || step == 'choose date'
                        ? const Color(0xff4CA9EE)
                        : const Color(0xff757575),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xffF0F4F9),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/images/icon_card1.png',
                      color: step == 'choose dokter' || step == 'choose date'
                          ? const Color(0xff4CA9EE)
                          : const Color(0xff757575),
                    ),
                  ),
                ),
              ),
              Text(
                '2. Pilih Dokter',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: step == 'choose dokter' || step == 'choose date'
                      ? const Color(0xff4CA9EE)
                      : const Color(0xff757575),
                ),
              ),
            ],
          ),
          Expanded(
            child: Divider(
              thickness: 2,
              color: step == 'choose date'
                  ? const Color(0xff4CA9EE)
                  : const Color(0xff757575),
            ),
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: step == 'choose date'
                    ? const Color(0xff4CA9EE)
                    : const Color(0xff757575),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xffF0F4F9),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/images/icon_card3.png',
                      color: step == 'choose date'
                          ? const Color(0xff4CA9EE)
                          : const Color(0xff757575),
                    ),
                  ),
                ),
              ),
              Text(
                '3. Pilih Tanggal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: step == 'choose date'
                      ? const Color(0xff4CA9EE)
                      : const Color(0xff757575),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
