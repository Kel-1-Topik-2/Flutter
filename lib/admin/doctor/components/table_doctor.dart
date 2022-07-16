import 'package:flutter/material.dart';
import 'package:hospital/admin/doctor/doctor_view_model.dart';
import 'package:hospital/admin/doctor/page/add_doctor_screen.dart';
import 'package:hospital/admin/doctor/page/detail_doctor_screen.dart';
import 'package:hospital/model/doctor.dart';
import 'package:number_paginator/number_paginator.dart';

class TableDoctor extends StatefulWidget {
  final DoctorViewModel doctorViewModel;
  const TableDoctor({
    Key? key,
    required this.doctorViewModel,
  }) : super(key: key);

  @override
  State<TableDoctor> createState() => _TableDoctorState();
}

class _TableDoctorState extends State<TableDoctor> {
  int currentPage = 0;
  int numPage = 1;
  int? amountData;

  double? page;

  String filter = "Semua Kategori";
  String showData = "All";

  bool isSearch = false;

  Map<int, List<Doctor>> tempData = {};
  Map<int, List<Doctor>> resultData = {};

  @override
  void initState() {
    super.initState();
    tempData[currentPage] = widget.doctorViewModel.doctors;
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
        widget.doctorViewModel.doctors.isNotEmpty == true
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
                      top: 4,
                      bottom: 4,
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
                                        .npa
                                        .toString()
                                    : ""
                                : resultData[currentPage] != null
                                    ? resultData[currentPage]![index]
                                        .npa
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
                                    ? tempData[currentPage]![index].namaLengkap!
                                    : ""
                                : resultData[currentPage] != null
                                    ? resultData[currentPage]![index]
                                        .namaLengkap!
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
                                    ? tempData[currentPage]![index].username!
                                    : ""
                                : resultData[currentPage] != null
                                    ? resultData[currentPage]![index].username!
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
                                    ? tempData[currentPage]![index].spesialis!
                                    : ""
                                : resultData[currentPage] != null
                                    ? resultData[currentPage]![index].spesialis!
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
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailDoctorScreenAdmin(
                                        id: isSearch == false
                                            ? tempData[currentPage]![index].id!
                                            : resultData[currentPage]![index]
                                                .id!,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.info_outline),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40.0),
                                        ),
                                      ),
                                      title: const Text(
                                        'Hapus Data Dokter',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      content: Builder(
                                        builder: (context) {
                                          var width =
                                              MediaQuery.of(context).size.width;
                                          return SizedBox(
                                            width: width / 4,
                                            child: const Text(
                                              'Yakin untuk menghapus data dokter?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'BATAL',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final scaffoldMessenger =
                                                ScaffoldMessenger.of(context);
                                            Navigator.pop(context);

                                            bool result = await widget
                                                .doctorViewModel
                                                .deleteDoctor(
                                              isSearch == false
                                                  ? tempData[currentPage]![
                                                          index]
                                                      .id!
                                                  : resultData[currentPage]![
                                                          index]
                                                      .id!,
                                              isSearch == false
                                                  ? tempData[currentPage]![
                                                          index]
                                                      .idUsername!
                                                  : resultData[currentPage]![
                                                          index]
                                                      .idUsername!,
                                            );

                                            if (result == true) {
                                              scaffoldMessenger.showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Berhasil Menghapus Data',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: const Text(
                                            'HAPUS',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins',
                                              color: Color(0xffEC0000),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        )
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
        if (widget.doctorViewModel.doctors.isNotEmpty == true) footer(),
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
                            page = widget.doctorViewModel.doctors.length /
                                int.parse(
                                  showData,
                                );
                            numPage = page!.ceil();
                          }

                          if (showData == 'All') {
                            amountData = widget.doctorViewModel.doctors.length;
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
              'NPA IDI',
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
              'Nama Lengkap',
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
              'Username',
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
              'Spesialis',
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
                      'NPA ID',
                      'Nama Lengkap',
                      'Spesialis'
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
                      hintText: 'Cari Data Dokter',
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
                  builder: (context) => const AddDoctorScreenAdmin(),
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
              'Tambah Data',
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
    List<Doctor> data = [];
    for (var i = start; i < end; i++) {
      if (widget.doctorViewModel.doctors.length > i) {
        data.add(widget.doctorViewModel.doctors[i]);
      }
    }
    return data;
  }

  void search(String searchText, String filter, int currentPage) {
    if (searchText.isEmpty) {
      isSearch = false;
    } else {
      if (filter == 'Semua Kategori') {
        resultData[currentPage] = tempData[currentPage]!.where((doctor) {
          return doctor.npa
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              doctor.namaLengkap!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              doctor.username!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              doctor.spesialis!
                  .toLowerCase()
                  .contains(searchText.toLowerCase());
        }).toList();
      }

      if (filter == 'NPA ID') {
        resultData[currentPage] = tempData[currentPage]!.where((doctor) {
          return doctor.npa.toString().toLowerCase().contains(
                searchText.toLowerCase(),
              );
        }).toList();
      }

      if (filter == 'Nama Lengkap') {
        resultData[currentPage] = tempData[currentPage]!.where((doctor) {
          return doctor.namaLengkap!.toLowerCase().contains(
                searchText.toLowerCase(),
              );
        }).toList();
      }

      if (filter == 'Spesialis') {
        resultData[currentPage] = tempData[currentPage]!.where((doctor) {
          return doctor.spesialis!.toLowerCase().contains(
                searchText.toLowerCase(),
              );
        }).toList();
      }
    }
  }
}
