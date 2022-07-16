import 'package:flutter/material.dart';
import 'package:hospital/admin/schedule/add_schedule/choose_patient_screen.dart';
import 'package:hospital/admin/schedule/schedule_view_model.dart';
import 'package:hospital/model/schedule.dart';
import 'package:number_paginator/number_paginator.dart';

class TableSchedule extends StatefulWidget {
  final ScheduleViewModel scheduleViewModel;
  const TableSchedule({
    Key? key,
    required this.scheduleViewModel,
  }) : super(key: key);

  @override
  State<TableSchedule> createState() => _TableScheduleState();
}

class _TableScheduleState extends State<TableSchedule> {
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
    tempData[currentPage] = widget.scheduleViewModel.schedules;
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
        widget.scheduleViewModel.schedules.isNotEmpty == true
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
                      top: 15,
                      bottom: 15,
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
                                        .noUrut
                                        .toString()
                                    : ""
                                : resultData[currentPage] != null
                                    ? resultData[currentPage]![index]
                                        .noUrut
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
                                    ? tempData[currentPage]![index].namaDokter!
                                    : ""
                                : resultData[currentPage] != null
                                    ? resultData[currentPage]![index]
                                        .namaDokter!
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
        if (widget.scheduleViewModel.schedules.isNotEmpty == true) footer(),
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
                            page = widget.scheduleViewModel.schedules.length /
                                int.parse(
                                  showData,
                                );
                            numPage = page!.ceil();
                          }

                          if (showData == 'All') {
                            amountData =
                                widget.scheduleViewModel.schedules.length;
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
              'Tanggal',
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
              'Antrian',
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
              'Nama Dokter',
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
              'JP',
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'No Antrian',
                      'Nama Pasien',
                      'Nama Dokter'
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
                      hintText: 'Cari Jadwal',
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
        SizedBox(
          width: 206,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChoosePatientScreenAdmin(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff4CA9EE),
              minimumSize: const Size.fromHeight(32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Tambah Jadwal',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    );
  }

  addTolist(int start, int end) {
    List<Schedule> data = [];
    for (var i = start; i < end; i++) {
      if (widget.scheduleViewModel.schedules.length > i) {
        data.add(widget.scheduleViewModel.schedules[i]);
      }
    }
    return data;
  }

  void search(String searchText, String filter, int currentPage) {
    if (searchText.isEmpty) {
      isSearch = false;
    } else {
      if (filter == 'Semua Kategori') {
        resultData[currentPage] = tempData[currentPage]!.where((schedule) {
          return schedule.tanggal!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              schedule.noUrut
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              schedule.namaPasien!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              schedule.jenisPerawatan!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              schedule.namaDokter!
                  .toLowerCase()
                  .contains(searchText.toLowerCase());
        }).toList();
      }

      if (filter == 'No Antrian') {
        resultData[currentPage] = tempData[currentPage]!.where((schedule) {
          return schedule.noUrut.toString().toLowerCase().contains(
                searchText.toLowerCase(),
              );
        }).toList();
      }

      if (filter == 'Nama Pasien') {
        resultData[currentPage] = tempData[currentPage]!.where((schedule) {
          return schedule.namaPasien!.toLowerCase().contains(
                searchText.toLowerCase(),
              );
        }).toList();
      }

      if (filter == 'Nama Dokter') {
        resultData[currentPage] = tempData[currentPage]!.where((schedule) {
          return schedule.namaDokter!.toLowerCase().contains(
                searchText.toLowerCase(),
              );
        }).toList();
      }
    }
  }
}
