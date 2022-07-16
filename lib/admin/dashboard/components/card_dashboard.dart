import 'package:flutter/material.dart';

class CardDashboard extends StatelessWidget {
  const CardDashboard({
    Key? key,
    required this.width,
    required this.title,
    required this.count,
    required this.icon,
  }) : super(key: key);

  final double width;
  final String title;
  final int count;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 3,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(3, 3),
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
              Text(
                title,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                icon,
                scale: 5,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
