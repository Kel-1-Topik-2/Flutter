import 'package:flutter/material.dart';
import 'package:hospital/admin/review/components/field_review.dart';
import 'package:hospital/admin/review/review_view_model.dart';
import 'package:hospital/state/hospital_state.dart';
import 'package:provider/provider.dart';

class FormReview extends StatefulWidget {
  const FormReview({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<FormReview> createState() => _FormReviewState();
}

class _FormReviewState extends State<FormReview> {
  var jadwalKunjunganController = TextEditingController();
  var idPasien = TextEditingController();
  var jenisPerawatan = TextEditingController();
  var namaPasien = TextEditingController();
  var namaDokter = TextEditingController();
  var diagnosa = TextEditingController();
  var catatan = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<ReviewViewModel>(context, listen: false);
      await viewModel.getReviewById(widget.id);
      jadwalKunjunganController.text =
          viewModel.s.tanggal != null ? viewModel.s.tanggal! : "";
      idPasien.text =
          viewModel.s.idPasien != null ? viewModel.s.idPasien.toString() : "";
      jenisPerawatan.text =
          viewModel.s.jenisPerawatan != null ? viewModel.s.jenisPerawatan! : "";
      namaPasien.text =
          viewModel.s.namaPasien != null ? viewModel.s.namaPasien! : "";
      namaDokter.text =
          viewModel.s.namaDokter != null ? viewModel.s.namaDokter! : "";
      diagnosa.text = viewModel.s.diagnosa != null ? viewModel.s.diagnosa! : "";
      catatan.text = viewModel.s.catatan != null ? viewModel.s.catatan! : "";
    });
  }

  @override
  void dispose() {
    super.dispose();
    jadwalKunjunganController.dispose();
    idPasien.dispose();
    jenisPerawatan.dispose();
    namaPasien.dispose();
    namaDokter.dispose();
    diagnosa.dispose();
    catatan.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewViewModel>(
      builder: (context, value, child) {
        if (value.state == HospitalState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (value.state == HospitalState.success) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataSchedule(value),
              const SizedBox(
                width: 20,
              ),
              review(value),
            ],
          );
        }

        return const Center(
          child: Text('data'),
        );
      },
    );
  }

  Expanded dataSchedule(ReviewViewModel value) {
    return Expanded(
      flex: 2,
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
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FieldReview(
                    textEditingController: jadwalKunjunganController,
                    title: 'Tanggal Kunjungan',
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Expanded(child: Text('')),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: FieldReview(
                    textEditingController: idPasien,
                    title: "ID",
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: FieldReview(
                    textEditingController: jenisPerawatan,
                    title: "Jenis Perawatan",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: FieldReview(
                    textEditingController: namaPasien,
                    title: "Nama Pasien",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: FieldReview(
                    textEditingController: namaDokter,
                    title: "Nama Dokter",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded review(ReviewViewModel value) {
    return Expanded(
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
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldReview(
              textEditingController: diagnosa,
              title: 'Diagnosa',
            ),
            const SizedBox(
              height: 30,
            ),
            FieldReview(
              textEditingController: catatan,
              title: 'Catatan',
            ),
          ],
        ),
      ),
    );
  }
}
