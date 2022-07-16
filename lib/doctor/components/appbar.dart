import 'package:flutter/material.dart';
import 'package:hospital/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appbar extends StatefulWidget {
  final String name;
  const Appbar({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        right: 50,
        left: 50,
      ),
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 90,
            height: 65,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
                PopupMenuButton(
                  key: const Key('dropdownKey'),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        key: const Key('logoutButton'),
                        value: 'logout',
                        child: Padding(
                          padding: const EdgeInsets.only(right: 100),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Logout"),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) async {
                    if (value == 'logout') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
