import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';
import 'package:hospital/admin/dashboard/dashboard_screen.dart';
import 'package:hospital/doctor/dashboard/dashboard_screen_doctor.dart';
import 'package:hospital/model/user.dart';
import 'package:hospital/login/login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late Size size;
  late double height, width;

  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  String? role;
  bool seePass = true;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? login = prefs.getString('login');
      if (login != null) {
        User user = User.fromJson2(jsonDecode(login));
        usernameController.text = user.username != null ? user.username! : "";
        passwordController.text = user.password != null ? user.password! : "";
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Form(
        key: formKey,
        child: SizedBox(
          width: width > 915 ? 435 : 300,
          child: Column(
            children: [
              chooseRole(),
              SizedBox(
                height: width > 915 ? 48 : 12,
              ),
              username(),
              const SizedBox(
                height: 12,
              ),
              password(),
              remember(),
              SizedBox(
                height: width > 915 ? 72 : 20,
              ),
              SizedBox(
                width: width > 915 ? 206 : 150,
                height: width > 915 ? 56 : 40,
                child: Consumer<LoginViewModel>(
                  builder: (context, value, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await value.login(
                            User(
                              username: usernameController.text,
                              password: passwordController.text,
                              role: role,
                            ),
                            role!,
                            rememberMe,
                          );

                          if (value.state == HospitalState.error) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Login Failed!',
                                ),
                              ),
                            );
                          }

                          if (value.state == HospitalState.success) {
                            if (role == 'Admin') {
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(),
                                ),
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DashboardScreenDoctor(),
                                ),
                              );
                            }
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Login Success',
                                ),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff4CA9EE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            width > 915 ? 20 : 10,
                          ),
                        ),
                      ),
                      child: value.state == HospitalState.loading
                          ? SizedBox(
                              height: width > 915 ? null : 20,
                              width: width > 915 ? null : 20,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: width > 915 ? 18 : 13,
                                fontFamily: 'Poppins',
                              ),
                            ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row remember() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: rememberMe,
          onChanged: (bool? value) {
            setState(() {
              rememberMe = value!;
            });
          },
        ),
        Text(
          'Remember Me',
          style: TextStyle(
            fontSize: width > 915 ? 14 : 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  SizedBox password() {
    return SizedBox(
      height: width > 915 ? null : 50,
      child: TextFormField(
        controller: passwordController,
        obscureText: seePass,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: width > 915 ? 18 : 13,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                seePass = !seePass;
              });
            },
            icon: seePass == true
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: "Input Password",
          labelText: "Password",
          hintStyle: TextStyle(
            color: const Color(0xff757575),
            fontWeight: FontWeight.w400,
            fontSize: width > 915 ? 18 : 13,
            fontFamily: 'Poppins',
          ),
          labelStyle: TextStyle(
            color: const Color(0xff757575),
            fontWeight: FontWeight.w400,
            fontSize: width > 915 ? 18 : 13,
            fontFamily: 'Poppins',
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width > 915 ? 20 : 10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width > 915 ? 20 : 10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width > 915 ? 20 : 10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width > 915 ? 20 : 10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Password Can't Be Empty!";
          }
          return null;
        },
      ),
    );
  }

  SizedBox username() {
    return SizedBox(
      height: width > 915 ? null : 50,
      child: TextFormField(
        controller: usernameController,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: width > 915 ? 18 : 13,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Input Username",
          labelText: "Username",
          hintStyle: TextStyle(
            color: const Color(0xff757575),
            fontWeight: FontWeight.w400,
            fontSize: width > 915 ? 18 : 13,
            fontFamily: 'Poppins',
          ),
          labelStyle: TextStyle(
            color: const Color(0xff757575),
            fontWeight: FontWeight.w400,
            fontSize: width > 915 ? 18 : 13,
            fontFamily: 'Poppins',
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width > 915 ? 20 : 10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width > 915 ? 20 : 10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width > 915 ? 20 : 10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width > 915 ? 20 : 10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Username Can't Be Empty!";
          }
          return null;
        },
      ),
    );
  }

  SizedBox chooseRole() {
    return SizedBox(
      height: width > 915 ? null : 50,
      child: DropdownButtonFormField(
        borderRadius: BorderRadius.circular(20),
        value: 'Pilih Role',
        validator: (value) {
          if (value == 'Pilih Role') {
            return "Role Can't Be Empty!";
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: width > 915
              ? null
              : const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xff53cd81),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(width > 915 ? 20 : 10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xff53cd81),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(width > 915 ? 20 : 10),
          ),
          filled: true,
          fillColor: const Color(0xff53cd81),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: width > 915 ? 35 : 20,
        ),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: width > 915 ? 18 : 13,
          fontFamily: 'Poppins',
        ),
        onChanged: (String? newValue) {
          setState(() {
            role = newValue!;
          });
        },
        items: [
          'Pilih Role',
          'Admin',
          'Doctor',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
      ),
    );
  }
}
