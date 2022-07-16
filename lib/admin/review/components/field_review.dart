import 'package:flutter/material.dart';

class FieldReview extends StatelessWidget {
  const FieldReview({
    Key? key,
    required this.textEditingController,
    required this.title,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Color(0xff358C56),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: textEditingController,
          readOnly: true,
          maxLines: title == 'Catatan' ? 10 : null,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF0F4F9),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
