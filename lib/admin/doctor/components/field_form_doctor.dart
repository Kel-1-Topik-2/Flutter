import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldFormDoctor extends StatelessWidget {
  const FieldFormDoctor({
    Key? key,
    required this.width,
    required this.title,
    required this.page,
    required this.textEditingController,
    required this.textInputFormatter,
    this.password,
  }) : super(key: key);

  final double width;
  final String title;
  final String page;
  final TextEditingController textEditingController;
  final TextEditingController? password;
  final TextInputFormatter? textInputFormatter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: width > 915 ? 20 : 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: const Color(0xff358C56),
              ),
            ),
            if (page == 'Add' || page == 'Edit')
              Text(
                '*',
                style: TextStyle(
                  fontSize: width > 915 ? 20 : 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Colors.red,
                ),
              ),
          ],
        ),
        SizedBox(
          height: width > 915 ? 11 : 5,
        ),
        TextFormField(
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
          obscureText: title == 'Kata Sandi' ||
                  title == 'Konfirmasi Kata Sandi' ||
                  title == 'Kata Sandi Baru' ||
                  title == 'Konfirmasi Kata Sandi Baru'
              ? true
              : false,
          readOnly: page == 'Detail' ? true : false,
          inputFormatters:
              textInputFormatter != null ? [textInputFormatter!] : [],
          controller: textEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF0F4F9),
            contentPadding: width > 915
                ? null
                : const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                width > 915 ? 20 : 10,
              ),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "$title Tidak Boleh Kosong!";
            }
            if (title == 'NPA ID') {
              if (value.length != 6) {
                return "NPA ID Harus 6 Karakter!";
              }
            }
            if (title == 'Username') {
              if (value.length < 8) {
                return "Username Minimal 8 Karakter!";
              }
            }

            if (title == 'Kata Sandi' || title == 'Kata Sandi Baru') {
              if (value.length < 8) {
                return "$title Minimal 8 Karakter!";
              }
            }

            if (title == 'Konfirmasi Kata Sandi' ||
                title == 'Konfirmasi Kata Sandi Baru') {
              if (value.length < 8) {
                return "$title Minimal 8 Karakter!";
              }
            }

            if (title == 'Konfirmasi Kata Sandi' ||
                title == 'Konfirmasi Kata Sandi Baru') {
              if (value != password!.text) {
                return 'Password Harus Sama';
              }
            }

            return null;
          },
        ),
      ],
    );
  }
}
