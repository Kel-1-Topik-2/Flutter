import 'package:flutter/material.dart';
import 'package:hospital/doctor/dashboard/dashboard_doctor_view_model.dart';
import 'package:hospital/doctor/review/review_screen.dart';
import 'package:hospital/model/schedule.dart';
import 'package:number_paginator/number_paginator.dart';

class TableDashboardDoctor extends StatefulWidget {
  const TableDashboardDoctor({
    Key? key,
    required this.dashboardDoctorviewModel,
    required this.name,
  }) : super(key: key);

  final DashboardDoctorviewModel dashboardDoctorviewModel;
  final String name;

  @override
  State<TableDashboardDoctor> createState() => _TableDashboardDoctorState();
}

class _TableDashboardDoctorState extends State<TableDashboardDoctor> {
  int currentPage = 0;
  int numPage = 1;
  int? amountData;

  double? page;

  String filter = "Semua Kategori";
  String showData = "All";

  bool isSearch = false;

  Map<int, List<Schedule>> tempData = {};
  Map<int, List<Schedule>> resultData = {};

  @override
  void initState() {
    super.initState();
    tempData[currentPage] = widget.dashboardDoctorviewModel.historySchedule;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topBar(context),
        const SizedBox(
          height: 40,
        ),
        header(),
        const SizedBox(
          height: 24,
        ),
        widget.dashboardDoctorviewModel.historySchedule.isNotEmpty == true
            ? ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: isSearch == false
                    ? tempData[currentPage] != null
                        ? tempData[currentPage]!.length
                        : 0
                    : resultData[currentPage] != null
                        ? resultData[currentPage]!.length
                        : 0,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(
                      top: 13,
                      bottom: 13,
                      left: 20,
                      right: 20,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            isSearch == false
                                ? tempData[currentPage] != null
                                    ? tempData[currentPage]![index]
                                        .id
                                        .toString()
                                    : ""
                                : resultData[currentPage] != null
                                    ? resultData[currentPage]![index]
                                        .id
                                        .toString()
                                    : "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            isSearch == false
                                ? tempData[currentPage] != null
                                    ? tempData[currentPage]![index].namaPasien!
                                    : ""
                                : resultData[currentPage] != null
                                    ? resultData[currentPage]![index]
                                        .namaPasien!
                                    : "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            isSearch == false
                                ? tempData[currentPage] != null
                                    ? tempData[currentPage]![index].tanggal!
                                    : ""
                                : resultData[currentPage] != null
                                    ? resultData[currentPage]![index].tanggal!
                                    : "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            isSearch == false
                                ? tempData[currentPage] != null
                                    ? tempData[currentPage]![index]
                                        .jenisPerawatan!
                                    : ""
                                : resultData[currentPage] != null
                                    ? resultData[currentPage]![index]
                                        .jenisPerawatan!
                                    : "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewScreen(
                                        idPasien: isSearch == false
                                            ? tempData[currentPage]![index]
                                                .idPasien!
                                            : resultData[currentPage]![index]
                                                .idPasien!,
                                        idSchedule: isSearch == false
                                            ? tempData[currentPage]![index].id!
                                            : resultData[currentPage]![index]
                                                .id!,
                                        name: widget.name,
                                      ),
                                    ),
                                  );
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0xff53CD81),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (
                  BuildContext context,
                  int index,
                ) =>
                    const SizedBox(
                  height: 10,
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
        if (widget.dashboardDoctorviewModel.historySchedule.isNotEmpty == true)
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
                            page = widget.dashboardDoctorviewModel
                                    .historySchedule.length /
                                int.parse(
                                  showData,
                                );
                            numPage = page!.ceil();
                          }

                          if (showData == 'All') {
                            amountData = widget.dashboardDoctorviewModel
                                .historySchedule.length;
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

  Container header() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: Color(0xff4CA9EE),
      ),
      child: Row(
        children: const [
          Expanded(
            child: Text(
              'ID',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Nama Pasien',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Tanggal Kunjungan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Jenis Perawatan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Aksi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 24,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(15),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 30,
                      color: Color(0xff53CD81),
                    ),
                    value: filter,
                    onChanged: (String? newValue) {
                      setState(() {
                        filter = newValue!;
                      });
                    },
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                    items: <String>[
                      'Semua Kategori',
                      'Nama Pasien',
                      'Tanggal Kunjungan',
                      'Jenis Perawatan'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const VerticalDivider(
                  color: Color(0xff4CA9EE),
                  width: 10,
                  thickness: 2,
                  indent: 7,
                  endIndent: 7,
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Cari Data Pasien',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6F6F6F),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        isSearch = true;
                        search(value, filter, currentPage);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff358C56),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(15),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  addTolist(int start, int end) {
    List<Schedule> data = [];
    for (var i = start; i < end; i++) {
      if (widget.dashboardDoctorviewModel.historySchedule.length > i) {
        data.add(widget.dashboardDoctorviewModel.historySchedule[i]);
      }
    }
    return data;
  }

  void search(String searchText, String filter, int currentPage) {
    if (searchText.isEmpty) {
      isSearch = false;
    } else {
      if (filter == 'Semua Kategori') {
        resultData[currentPage] = tempData[currentPage]!.where((patient) {
          return patient.id
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              patient.namaPasien!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              patient.tanggal!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              patient.jenisPerawatan!
                  .toLowerCase()
                  .contains(searchText.toLowerCase());
        }).toList();
      }

      if (filter == 'Nama Pasien') {
        resultData[currentPage] = tempData[currentPage]!.where((patient) {
          return patient.namaPasien!.toLowerCase().contains(
                searchText.toLowerCase(),
              );
        }).toList();
      }

      if (filter == 'Tanggal Kunjungan') {
        resultData[currentPage] = tempData[currentPage]!.where((patient) {
          return patient.tanggal!.toLowerCase().contains(
                searchText.toLowerCase(),
              );
        }).toList();
      }

      if (filter == 'Jenis Perawatan') {
        resultData[currentPage] = tempData[currentPage]!.where((patient) {
          return patient.jenisPerawatan!.toLowerCase().contains(
                searchText.toLowerCase(),
              );
        }).toList();
      }
    }
  }
}
