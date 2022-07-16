import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital/admin/doctor/components/field_form_doctor.dart';
import 'package:hospital/admin/doctor/doctor_screen.dart';
import 'package:hospital/admin/doctor/doctor_view_model.dart';
import 'package:hospital/admin/doctor/page/detail_doctor_screen.dart';
import 'package:hospital/model/doctor.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class FormTabletDoctor extends StatefulWidget {
  const FormTabletDoctor({
    Key? key,
    this.doctorViewModel,
    required this.page,
  }) : super(key: key);

  final DoctorViewModel? doctorViewModel;
  final String page;

  @override
  State<FormTabletDoctor> createState() => _FormTabletDoctorState();
}

class _FormTabletDoctorState extends State<FormTabletDoctor> {
  var formKey = GlobalKey<FormState>();
  var namaLengkapController = TextEditingController();
  var npaIdiController = TextEditingController();
  var spesialisController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  late Size size;
  late double height, width;

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.page == 'Detail' || widget.page == 'Edit') {
      namaLengkapController.text = widget.doctorViewModel!.d.namaLengkap != null
          ? widget.doctorViewModel!.d.namaLengkap!
          : "";
      npaIdiController.text = widget.doctorViewModel!.d.npa != null
          ? widget.doctorViewModel!.d.npa.toString()
          : "";
      spesialisController.text = widget.doctorViewModel!.d.spesialis != null
          ? widget.doctorViewModel!.d.spesialis!
          : "";
      usernameController.text = widget.doctorViewModel!.d.username != null
          ? widget.doctorViewModel!.d.username!
          : "";
    }
  }

  @override
  void dispose() {
    super.dispose();
    namaLengkapController.dispose();
    npaIdiController.dispose();
    spesialisController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
          FieldFormDoctor(
            width: width,
            title: 'Nama Lengkap',
            page: widget.page,
            textEditingController: namaLengkapController,
            textInputFormatter: null,
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Expanded(
                child: FieldFormDoctor(
                  width: width,
                  title: 'NPA ID',
                  page: widget.page,
                  textEditingController: npaIdiController,
                  textInputFormatter: FilteringTextInputFormatter.digitsOnly,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: FieldFormDoctor(
                  width: width,
                  title: 'Spesialis',
                  page: widget.page,
                  textEditingController: spesialisController,
                  textInputFormatter: null,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          FieldFormDoctor(
            width: width,
            title: 'Username',
            page: widget.page,
            textEditingController: usernameController,
            textInputFormatter: null,
          ),
          if (widget.page == 'Add' || widget.page == 'Edit')
            const SizedBox(
              height: 32,
            ),
          if (widget.page == 'Add' || widget.page == 'Edit')
            Row(
              children: [
                Expanded(
                  child: FieldFormDoctor(
                    width: width,
                    title:
                        widget.page == 'Add' ? 'Kata Sandi' : 'Kata Sandi Baru',
                    page: widget.page,
                    textEditingController: passwordController,
                    textInputFormatter: null,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: FieldFormDoctor(
                    width: width,
                    title: widget.page == 'Add'
                        ? 'Konfirmasi Kata Sandi'
                        : 'Konfirmasi Kata Sandi Baru',
                    page: widget.page,
                    textEditingController: confirmPasswordController,
                    password: passwordController,
                    textInputFormatter: null,
                  ),
                ),
              ],
            ),
          if (widget.page == 'Add' || widget.page == 'Edit')
            const SizedBox(
              height: 70,
            ),
          if (widget.page == 'Add' || widget.page == 'Edit')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 206,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.page == 'Edit') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailDoctorScreenAdmin(
                              id: widget.doctorViewModel!.d.id!,
                            ),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoctorScreenAdmin(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size.fromHeight(32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      side: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      'BATAL',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Consumer<DoctorViewModel>(
                  builder: (context, value, child) {
                    if (widget.page == 'Add') {
                      return SizedBox(
                        width: 206,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: value.state == HospitalState.success
                              ? () async {
                                  if (formKey.currentState!.validate()) {
                                    bool result = await value.addDoctor(
                                      Doctor(
                                        username: usernameController.text,
                                        password: passwordController.text,
                                        namaLengkap: namaLengkapController.text,
                                        spesialis: spesialisController.text,
                                        npa: int.parse(npaIdiController.text),
                                      ),
                                    );

                                    if (result == true) {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Berhasil Menambahkan Data',
                                          ),
                                        ),
                                      );
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DoctorScreenAdmin(),
                                        ),
                                      );
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Gagal Menambahkan Data',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            minimumSize: const Size.fromHeight(32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: value.state == HospitalState.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.blue,
                                )
                              : const Text(
                                  'SIMPAN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: 206,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: isEdit == false
                              ? () async {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      isEdit = true;
                                    });
                                    bool result = await value.editDoctor(
                                      Doctor(
                                        id: value.d.id,
                                        username: usernameController.text,
                                        password: passwordController.text,
                                        namaLengkap: namaLengkapController.text,
                                        spesialis: spesialisController.text,
                                        npa: int.parse(npaIdiController.text),
                                        idUsername: value.d.idUsername,
                                      ),
                                    );

                                    if (result == true) {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Berhasil Mengubah Data',
                                          ),
                                        ),
                                      );
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailDoctorScreenAdmin(
                                            id: value.d.id!,
                                          ),
                                        ),
                                      );
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Gagal Mengubah Data',
                                          ),
                                        ),
                                      );
                                    }
                                    setState(() {
                                      isEdit = false;
                                    });
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            minimumSize: const Size.fromHeight(32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: isEdit == true
                              ? const CircularProgressIndicator(
                                  color: Colors.blue,
                                )
                              : const Text(
                                  'SIMPAN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    }
                  },
                ),
              ],
            )
        ],
      ),
    );
  }
}
