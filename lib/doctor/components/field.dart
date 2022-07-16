import 'package:flutter/material.dart';

class FieldProcess extends StatelessWidget {
  const FieldProcess({
    Key? key,
    required this.title,
    required this.textEditingController,
    required this.readOnly,
    this.line,
  }) : super(key: key);

  final String title;
  final TextEditingController textEditingController;
  final bool readOnly;
  final int? line;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color(0xff358C56),
              ),
            ),
            if (readOnly == false)
              const Text(
                '*',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xffEC0000),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          readOnly: readOnly,
          controller: textEditingController,
          maxLines: line,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
            color: Color(0xff757575),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF0F4F9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return '$title Tidak Boleh Kosong';
            }

            return null;
          },
        ),
      ],
    );
  }
}
