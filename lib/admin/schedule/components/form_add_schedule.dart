import 'package:flutter/material.dart';
import 'package:hospital/admin/schedule/add_schedule/choose_doctor_screen.dart';
import 'package:hospital/admin/schedule/schedule_screen.dart';
import 'package:hospital/admin/schedule/schedule_view_model.dart';
import 'package:hospital/model/schedule.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormAddSchedule extends StatefulWidget {
  const FormAddSchedule({
    Key? key,
    required this.idDokter,
    required this.idPasien,
    required this.namaDokter,
    required this.namaPasien,
  }) : super(key: key);

  final int idPasien, idDokter;
  final String namaPasien, namaDokter;

  @override
  State<FormAddSchedule> createState() => _FormAddScheduleState();
}

class _FormAddScheduleState extends State<FormAddSchedule> {
  var formKey = GlobalKey<FormState>();
  var dateController = TextEditingController();
  var jenisPerawatan = TextEditingController();
  String date = 'yyyy-mm-dd';

  @override
  void initState() {
    super.initState();
    jenisPerawatan.text = 'Pilih Jenis Perawatan';
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    jenisPerawatan.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(40),
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
            child: card1(),
          ),
          const SizedBox(
            height: 45,
          ),
          Row(
            children: [
              Expanded(
                child: card2(),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: card3(),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 400,
              right: 400,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 206,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseDoctorScreenAdmin(
                              idPasien: widget.idPasien,
                              namaPasien: widget.namaPasien,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffF0F4F9),
                        minimumSize: const Size.fromHeight(32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        side: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      child: const Text(
                        'KEMBALI',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Consumer<ScheduleViewModel>(
                  builder: (context, value, child) {
                    return Expanded(
                      child: SizedBox(
                        width: 206,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: value.state == HospitalState.success
                              ? () async {
                                  if (formKey.currentState!.validate()) {
                                    bool result =
                                        await value.addSchedule(Schedule(
                                      idDokter: widget.idDokter,
                                      idPasien: widget.idPasien,
                                      jenisPerawatan: jenisPerawatan.text,
                                      tanggal: dateController.text,
                                    ));

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
                                              const ScheduleScreenAdmin(),
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
                            primary: const Color(0xff4CA9EE),
                            minimumSize: const Size.fromHeight(32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: value.state == HospitalState.loading
                              ? const CircularProgressIndicator()
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
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container card3() {
    return Container(
      padding: const EdgeInsets.all(40),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Jenis Perawatan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xff358C56),
                ),
              ),
              Text(
                '*',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          DropdownButtonFormField(
            validator: (value) {
              if (value == 'Pilih Jenis Perawatan') {
                return 'Silahkan Pilih Jenis Perawatan';
              }
              return null;
            },
            borderRadius: BorderRadius.circular(20),
            value: jenisPerawatan.text,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: 35,
            ),
            onChanged: (String? newValue) {
              setState(() {
                jenisPerawatan.text = newValue!;
              });
            },
            items: [
              'Pilih Jenis Perawatan',
              'Perawatan Biasa',
              'Rawat Jalan',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Container card2() {
    return Container(
      padding: const EdgeInsets.all(40),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Pilih Tanggal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xff358C56),
                ),
              ),
              Text(
                '*',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: dateController,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Tanggal Tidak Boleh Kosong!';
              } else {
                String now = DateFormat('yyyy-MM-dd').format(DateTime.now());

                DateTime date1 = DateFormat("yyyy-MM-dd").parse(value);

                DateTime date2 = DateFormat("yyyy-MM-dd").parse(now);

                int dateInput = date1.millisecondsSinceEpoch;
                int dateNow = date2.millisecondsSinceEpoch;

                if (dateInput < dateNow) {
                  return 'Tidak Boleh Input Tanggal Yang Sudah Lewat!';
                }
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.calendar_today,
                color: Colors.black,
              ),
              hintText: 'yyyy-mm-dd',
              hintStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

                setState(() {
                  date = formattedDate;
                  dateController.text = date;
                });
              }
            },
          )
        ],
      ),
    );
  }

  Row card1() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              const Text(
                'Nama Pasien : ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xff757575),
                ),
              ),
              Text(
                widget.namaPasien,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color(0xff757575),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              const Text(
                'Nama Dokter : ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xff757575),
                ),
              ),
              Text(
                widget.namaDokter,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color(0xff757575),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
