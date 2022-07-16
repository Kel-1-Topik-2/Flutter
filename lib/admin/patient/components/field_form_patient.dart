import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldFormPatient extends StatelessWidget {
  const FieldFormPatient({
    Key? key,
    required this.width,
    required this.title,
    required this.page,
    required this.textEditingController,
    required this.textInputFormatter,
  }) : super(key: key);

  final double width;
  final String title;
  final String page;
  final TextEditingController textEditingController;
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
          readOnly: page == 'Detail' ? true : false,
          maxLines: title == 'Alamat Rumah' ? 4 : 1,
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
            if (title == 'NIK') {
              if (value.length != 16) {
                return "NIK Harus 16 Karakter!";
              }
            }
            if (title == 'Usia') {
              if (value.length > 3) {
                return "Maks 3 digit angka!";
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}
