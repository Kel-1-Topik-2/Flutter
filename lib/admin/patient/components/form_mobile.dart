import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hospital/admin/patient/components/field_form_patient.dart';
import 'package:hospital/admin/patient/patient_screen.dart';
import 'package:hospital/admin/patient/patient_view_model.dart';
import 'package:hospital/model/patient.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class FormMobilePatient extends StatefulWidget {
  const FormMobilePatient({
    Key? key,
    this.patientViewModel,
    required this.page,
  }) : super(key: key);

  final PatientViewModel? patientViewModel;
  final String page;

  @override
  State<FormMobilePatient> createState() => _FormMobilePatientState();
}

class _FormMobilePatientState extends State<FormMobilePatient> {
  var formKey = GlobalKey<FormState>();
  var namaLengkapController = TextEditingController();
  var nomorHandphoneController = TextEditingController();
  var nikController = TextEditingController();
  var usiaController = TextEditingController();
  var alamatRumahController = TextEditingController();

  late Size size;
  late double height, width;

  bool isEdit = false;

  final List<String> _status = ["Laki laki", "Perempuan"];
  String _jenisKelamin = 'Laki laki';

  @override
  void initState() {
    super.initState();
    if (widget.page == 'Detail' || widget.page == 'Edit') {
      namaLengkapController.text =
          widget.patientViewModel!.p.namaLengkap != null
              ? widget.patientViewModel!.p.namaLengkap!
              : "";
      nomorHandphoneController.text = widget.patientViewModel!.p.telp != null
          ? widget.patientViewModel!.p.telp.toString()
          : "";
      nikController.text = widget.patientViewModel!.p.nik != null
          ? widget.patientViewModel!.p.nik.toString()
          : "";
      usiaController.text = widget.patientViewModel!.p.usia != null
          ? widget.patientViewModel!.p.usia.toString()
          : "";
      alamatRumahController.text = widget.patientViewModel!.p.alamat != null
          ? widget.patientViewModel!.p.alamat!
          : "";
      _jenisKelamin = widget.patientViewModel!.p.jk != null
          ? widget.patientViewModel!.p.jk!
          : "";
    }
  }

  @override
  void dispose() {
    super.dispose();
    namaLengkapController.dispose();
    nomorHandphoneController.dispose();
    nikController.dispose();
    usiaController.dispose();
    alamatRumahController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Form(
      key: formKey,
      child: Column(
        children: [
          FieldFormPatient(
            width: width,
            title: 'Nama Lengkap',
            page: widget.page,
            textEditingController: namaLengkapController,
            textInputFormatter: null,
          ),
          const SizedBox(
            height: 10,
          ),
          FieldFormPatient(
            width: width,
            title: 'Nomor Handphone',
            page: widget.page,
            textEditingController: nomorHandphoneController,
            textInputFormatter: FilteringTextInputFormatter.digitsOnly,
          ),
          const SizedBox(
            height: 10,
          ),
          FieldFormPatient(
            width: width,
            title: 'NIK',
            page: widget.page,
            textEditingController: nikController,
            textInputFormatter: FilteringTextInputFormatter.digitsOnly,
          ),
          const SizedBox(
            height: 10,
          ),
          FieldFormPatient(
            width: width,
            title: 'Usia',
            page: widget.page,
            textEditingController: usiaController,
            textInputFormatter: FilteringTextInputFormatter.digitsOnly,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Jenis Kelamin',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xff358C56),
                    ),
                  ),
                  if (widget.page == 'Add' || widget.page == 'Edit')
                    const Text(
                      '*',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
              RadioGroup<String>.builder(
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Popins',
                ),
                direction: Axis.horizontal,
                horizontalAlignment: MainAxisAlignment.start,
                groupValue: _jenisKelamin,
                onChanged: widget.page == 'Detail'
                    ? null
                    : (value) => setState(() {
                          _jenisKelamin = value!;
                        }),
                items: _status,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
                activeColor: Colors.blue,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FieldFormPatient(
            width: width,
            title: 'Alamat Rumah',
            page: widget.page,
            textEditingController: alamatRumahController,
            textInputFormatter: null,
          ),
          const SizedBox(
            height: 30,
          ),
          if (widget.page == 'Add' || widget.page == 'Edit')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PatientScreenAdmin(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size.fromHeight(32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    child: const Text(
                      'BATAL',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Consumer<PatientViewModel>(
                  builder: (context, value, child) {
                    return SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: value.state == HospitalState.success
                            ? () async {
                                setState(() {
                                  isEdit = true;
                                });
                                bool result = false;
                                if (formKey.currentState!.validate()) {
                                  if (widget.page == 'Add') {
                                    result = await value.addPatient(
                                      Patient(
                                        id: 0,
                                        namaLengkap: namaLengkapController.text,
                                        nik: int.parse(
                                          nikController.text,
                                        ),
                                        usia: int.parse(
                                          usiaController.text,
                                        ),
                                        jk: _jenisKelamin,
                                        telp: int.parse(
                                          nomorHandphoneController.text,
                                        ),
                                        alamat: alamatRumahController.text,
                                      ),
                                    );
                                  } else {
                                    result = await value.editPatient(
                                      Patient(
                                        id: value.p.id,
                                        namaLengkap: namaLengkapController.text,
                                        nik: int.parse(
                                          nikController.text,
                                        ),
                                        usia: int.parse(
                                          usiaController.text,
                                        ),
                                        jk: _jenisKelamin,
                                        telp: int.parse(
                                          nomorHandphoneController.text,
                                        ),
                                        alamat: alamatRumahController.text,
                                      ),
                                    );
                                  }

                                  if (result == true) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: widget.page == 'Add'
                                            ? const Text(
                                                'Berhasil Menambahkan Data',
                                              )
                                            : const Text(
                                                'Berhasil Mengubah Data',
                                              ),
                                      ),
                                    );
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PatientScreenAdmin(),
                                      ),
                                    );
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: widget.page == 'Add'
                                            ? const Text(
                                                'Gagal Menambahkan Data',
                                              )
                                            : const Text(
                                                'Gagal Mengubah Data',
                                              ),
                                      ),
                                    );
                                  }
                                }
                                setState(() {
                                  isEdit = false;
                                });
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          minimumSize: const Size.fromHeight(32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: widget.page == 'Add'
                            ? value.state == HospitalState.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.blue,
                                  )
                                : const Text(
                                    'SIMPAN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  )
                            : isEdit == true
                                ? const CircularProgressIndicator(
                                    color: Colors.blue,
                                  )
                                : const Text(
                                    'SIMPAN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                      ),
                    );
                  },
                ),
              ],
            )
        ],
      ),
    );
  }
}
