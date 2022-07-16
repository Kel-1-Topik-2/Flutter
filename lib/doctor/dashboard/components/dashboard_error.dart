import 'package:flutter/material.dart';

class DashboardError extends StatelessWidget {
  const DashboardError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/notfound.png',
        scale: 3,
      ),
    );
  }
}
