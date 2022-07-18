import 'package:flutter/material.dart';
import 'package:hospital/doctor/components/field.dart';
import 'package:hospital/doctor/dashboard/dashboard_screen_doctor.dart';
import 'package:hospital/doctor/process/process_view_model.dart';
import 'package:hospital/model/schedule.dart';
import 'package:intl/intl.dart';

class Form2 extends StatefulWidget {
  const Form2({Key? key, required this.processViewModel, required this.page})
      : super(key: key);

  final String page;
  final ProcessViewModel processViewModel;

  @override
  State<Form2> createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  var formKey = GlobalKey<FormState>();
  var diagnosa = TextEditingController();
  var catatan = TextEditingController();
  var dateController = TextEditingController();
  String date = 'yyyy-mm-dd';

  bool result = false;

  @override
  void dispose() {
    super.dispose();
    diagnosa.dispose();
    catatan.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        card1(),
        const SizedBox(
          height: 72,
        ),
        if (widget.processViewModel.s.jenisPerawatan == 'Rawat Jalan' &&
            widget.page == 'proses')
          card2(),
        if (widget.processViewModel.s.jenisPerawatan == 'Rawat Jalan' &&
            widget.page == 'proses')
          const SizedBox(
            height: 72,
          ),
        if (widget.page == 'proses') button(),
      ],
    );
  }

  Container card1() {
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
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Catatan Medis',
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
              width: 500,
              child: FieldProcess(
                title: 'Diagnosa',
                textEditingController:
                    widget.processViewModel.s.diagnosa != null
                        ? TextEditingController(
                            text: widget.processViewModel.s.diagnosa)
                        : diagnosa,
                readOnly:
                    widget.processViewModel.s.diagnosa != null ? true : false,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FieldProcess(
              title: 'Catatan',
              textEditingController: widget.processViewModel.s.catatan != null
                  ? TextEditingController(
                      text: widget.processViewModel.s.catatan)
                  : catatan,
              readOnly:
                  widget.processViewModel.s.catatan != null ? true : false,
              line: 6,
            ),
          ],
        ),
      ),
    );
  }

  Row button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 206,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffF0F4F9),
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
        SizedBox(
          width: 206,
          height: 55,
          child: ElevatedButton(
            onPressed: result == false
                ? () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        result = true;
                      });
                      bool r = false;
                      if (widget.processViewModel.s.jenisPerawatan ==
                          'Perawatan Biasa') {
                        r = await widget.processViewModel.prosesPasien(
                          Schedule(
                            id: widget.processViewModel.s.id,
                            controll: widget.processViewModel.s.tanggal,
                            catatan: catatan.text,
                            diagnosa: diagnosa.text,
                          ),
                        );
                      } else {
                        r = await widget.processViewModel
                            .prosesPasienRawatJalan(
                          Schedule(
                            id: widget.processViewModel.s.id,
                            idDokter: widget.processViewModel.s.idDokter,
                            idPasien: widget.processViewModel.s.idPasien,
                            jenisPerawatan:
                                widget.processViewModel.s.jenisPerawatan,
                            tanggal: dateController.text,
                            controll: dateController.text,
                            catatan: catatan.text,
                            diagnosa: diagnosa.text,
                          ),
                        );
                      }

                      if (r == true) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Berhasil Proses Data',
                            ),
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreenDoctor(),
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Gagal Proses Data',
                            ),
                          ),
                        );
                      }
                      setState(() {
                        result = false;
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
            child: result == true
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
        ),
      ],
    );
  }

  Padding card2() {
    return Padding(
      padding: const EdgeInsets.only(right: 500),
      child: Container(
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
          right: 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kontrol Selanjutnya',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Pilih Tanggal',
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
            TextFormField(
              controller: dateController,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color: Color(0xff757575),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF0F4F9),
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
                hintText: 'yyyy-mm-dd',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color(0xffA0A0A0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              readOnly: true,
              validator: (value) {
                if (value!.isNotEmpty == true) {
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
            ),
          ],
        ),
      ),
    );
  }
}
