import 'package:flutter/material.dart';
import 'package:hospital/doctor/components/appbar.dart';
import 'package:hospital/doctor/components/form1.dart';
import 'package:hospital/doctor/components/form2.dart';
import 'package:hospital/doctor/dashboard/dashboard_screen_doctor.dart';
import 'package:hospital/doctor/process/process_view_model.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({
    Key? key,
    this.idPasien,
    this.idSchedule,
    required this.name,
  }) : super(key: key);

  final int? idPasien;
  final int? idSchedule;
  final String name;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  late Size size;
  late double height, width;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<ProcessViewModel>(context, listen: false);
      await viewModel.getPatientById(widget.idPasien!, widget.idSchedule!);
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: const Color(0xffF0F4F9),
            ),
            Column(
              children: [
                Appbar(
                  name: widget.name,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 50,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardScreenDoctor(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 45,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Proses Data',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff358C56),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Consumer<ProcessViewModel>(
                                    builder: (context, value, child) {
                                      if (value.state ==
                                          HospitalState.loading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (value.state ==
                                          HospitalState.success) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'Tanggal Kunjungan : ',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                Text(
                                                  value.s.tanggal!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 72,
                                            ),
                                            Form1(
                                              processViewModel: value,
                                            ),
                                            const SizedBox(
                                              height: 72,
                                            ),
                                            Form2(
                                              processViewModel: value,
                                              page: 'proses',
                                            ),
                                          ],
                                        );
                                      }

                                      return const Center(
                                        child: Text('Data Tidak Ditemukan'),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 72,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
