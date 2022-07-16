import 'package:flutter/material.dart';
import 'package:hospital/doctor/dashboard/dashboard_doctor_view_model.dart';
import 'package:hospital/doctor/process/process_screen.dart';
import 'package:hospital/model/schedule.dart';
import 'package:number_paginator/number_paginator.dart';

class TableScheduleAll extends StatefulWidget {
  const TableScheduleAll({
    Key? key,
    required this.dashboardDoctorviewModel,
    required this.name,
  }) : super(key: key);

  final DashboardDoctorviewModel dashboardDoctorviewModel;
  final String name;

  @override
  State<TableScheduleAll> createState() => _TableScheduleAllState();
}

class _TableScheduleAllState extends State<TableScheduleAll> {
  int currentPage = 0;
  int numPage = 1;
  int? amountData;

  double? page;

  String filter = "Semua Kategori";
  String showData = "All";

  Map<int, List<Schedule>> tempData = {};

  @override
  void initState() {
    super.initState();
    tempData[currentPage] = widget.dashboardDoctorviewModel.scheduleToday;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.dashboardDoctorviewModel.scheduleToday.isNotEmpty == true
            ? ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tempData[currentPage] != null
                    ? tempData[currentPage]!.length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tempData[currentPage] != null
                                    ? tempData[currentPage]![index].namaPasien!
                                    : "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/Icons (1).png',
                                    scale: 3,
                                    color: const Color(0xff757575),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    tempData[currentPage] != null
                                        ? tempData[currentPage]![index]
                                            .noUrut
                                            .toString()
                                        : "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/Icons (2).png',
                                        scale: 3,
                                        color: const Color(0xff757575),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        tempData[currentPage] != null
                                            ? tempData[currentPage]![index]
                                                .idPasien
                                                .toString()
                                            : "",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/Icons (3).png',
                                        scale: 3,
                                        color: const Color(0xff757575),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        tempData[currentPage] != null
                                            ? tempData[currentPage]![index]
                                                .jenisPerawatan!
                                            : "",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProcessScreen(
                                      idPasien: widget.dashboardDoctorviewModel
                                          .scheduleToday[index].idPasien,
                                      idSchedule: widget
                                          .dashboardDoctorviewModel
                                          .scheduleToday[index]
                                          .id,
                                      name: widget.name,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xff4CA9EE),
                                minimumSize: const Size.fromHeight(32),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: const Text(
                                'Proses Data',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 30,
                ),
              )
            : Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/notfound.png',
                      scale: 3,
                    ),
                  ),
                  const Text(
                    'Hasil pencarian data tidak dapat ditemukan, silakan coba lagi.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  )
                ],
              ),
        const SizedBox(
          height: 60,
        ),
        if (widget.dashboardDoctorviewModel.scheduleToday.isNotEmpty == true)
          footer(),
      ],
    );
  }

  Row footer() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              const Text(
                'Jumlah data yang ditampilkan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 25,
                    ),
                    value: showData,
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          showData = newValue!;
                          currentPage = 0;
                          if (showData == 'All') {
                            numPage = 1;
                          } else {
                            page = widget.dashboardDoctorviewModel.scheduleToday
                                    .length /
                                int.parse(
                                  showData,
                                );
                            numPage = page!.ceil();
                          }

                          if (showData == 'All') {
                            amountData = widget
                                .dashboardDoctorviewModel.scheduleToday.length;
                          } else {
                            amountData = int.parse(
                              showData,
                            );
                          }
                          tempData.clear();
                          for (var i = 0; i < numPage; i++) {
                            tempData[i] = addTolist(
                              i * amountData!,
                              (i + 1) * amountData!,
                            );
                          }
                        },
                      );
                    },
                    items: <String>[
                      'All',
                      '5',
                      '10',
                      '20',
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: NumberPaginator(
            numberPages: numPage,
            onPageChange: (int index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
        ),
      ],
    );
  }

  addTolist(int start, int end) {
    List<Schedule> data = [];
    for (var i = start; i < end; i++) {
      if (widget.dashboardDoctorviewModel.scheduleToday.length > i) {
        data.add(widget.dashboardDoctorviewModel.scheduleToday[i]);
      }
    }
    return data;
  }
}
