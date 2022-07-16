import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hospital/doctor/components/field.dart';
import 'package:hospital/doctor/process/process_view_model.dart';

class Form1 extends StatefulWidget {
  const Form1({
    Key? key,
    required this.processViewModel,
  }) : super(key: key);

  final ProcessViewModel processViewModel;

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 7,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        left: 50,
        top: 50,
        bottom: 50,
        right: 220,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Pribadi Pasien',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 300,
            child: FieldProcess(
              title: 'ID',
              textEditingController: TextEditingController(
                text: widget.processViewModel.s.id.toString(),
              ),
              readOnly: true,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldProcess(
                      title: 'Nama Lengkap',
                      textEditingController: TextEditingController(
                        text: widget.processViewModel.s.namaPasien!,
                      ),
                      readOnly: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldProcess(
                      title: 'Nomor Handphone',
                      textEditingController: TextEditingController(
                        text: widget.processViewModel.p.telp.toString(),
                      ),
                      readOnly: true,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldProcess(
                      title: 'NIK',
                      textEditingController: TextEditingController(
                        text: widget.processViewModel.s.nikPasien.toString(),
                      ),
                      readOnly: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldProcess(
                      title: 'Usia',
                      textEditingController: TextEditingController(
                        text: widget.processViewModel.s.usiaPasien.toString(),
                      ),
                      readOnly: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jenis Kelamin',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xff358C56),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RadioGroup<String>.builder(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Popins',
                      ),
                      groupValue: widget.processViewModel.p.jk.toString(),
                      onChanged: null,
                      items: const [
                        'Laki laki',
                        'Perempuan',
                      ],
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          FieldProcess(
            title: 'Alamat Rumah',
            textEditingController: TextEditingController(
              text: widget.processViewModel.p.alamat!,
            ),
            readOnly: true,
          ),
        ],
      ),
    );
  }
}
