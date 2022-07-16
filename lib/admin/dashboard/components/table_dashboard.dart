import 'package:flutter/material.dart';
import 'package:hospital/admin/dashboard/dashboard_view_model.dart';

class TableDashboard extends StatelessWidget {
  final DashboardViewModel dashboardViewModel;
  const TableDashboard({
    Key? key,
    required this.dashboardViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(),
        const SizedBox(
          height: 15,
        ),
        body(dashboardViewModel),
      ],
    );
  }

  ListView body(DashboardViewModel value) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: value.schedules.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
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
                  value.schedules[index].tanggal!,
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
                  value.schedules[index].noUrut.toString(),
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
                  value.schedules[index].namaPasien!,
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
                  value.schedules[index].namaDokter!,
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
                  value.schedules[index].jenisPerawatan!,
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
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
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
                fontSize: 18,
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
                fontSize: 18,
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
                fontSize: 18,
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
                fontSize: 18,
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
                fontSize: 18,
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
}
