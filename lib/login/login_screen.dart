import 'package:flutter/material.dart';
import 'package:hospital/login/components/form_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Size size;
  late double height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Image.asset(
                    'assets/images/left_bg.png',
                    height: height,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "Selamat Datang Kembali!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width > 915 ? 48 : 30,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(
                          height: width > 915 ? 12 : 0,
                        ),
                        Text(
                          "Silahkan login untuk melanjutkan",
                          style: TextStyle(
                            fontSize: width > 915 ? 18 : 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(
                          height: width > 915 ? 120 : 40,
                        ),
                        const LoginForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
