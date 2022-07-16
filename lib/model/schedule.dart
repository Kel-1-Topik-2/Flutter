class Schedule {
  int? id;
  int? noUrut;
  int? idPasien;
  int? idDokter;
  int? nikPasien;
  int? usiaPasien;
  String? tanggal;
  String? namaPasien;
  String? namaDokter;
  String? jenisPerawatan;
  String? catatan;
  String? diagnosa;
  String? controll;

  Schedule({
    this.id,
    this.tanggal,
    this.noUrut,
    this.idPasien,
    this.idDokter,
    this.namaPasien,
    this.nikPasien,
    this.usiaPasien,
    this.namaDokter,
    this.jenisPerawatan,
    this.catatan,
    this.diagnosa,
    this.controll,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      tanggal: json['tanggal'],
      noUrut: json['nourut'],
      idPasien: json['pasien']['id'],
      idDokter: json['dokter']['id'],
      namaPasien: json['pasien']['namapasien'],
      nikPasien: json['pasien']['nik'],
      usiaPasien: json['pasien']['umur'],
      namaDokter: json['dokter']['namadokter'],
      jenisPerawatan: json['jp'],
      catatan: json['catatan'],
      diagnosa: json['diagnosa'],
      controll: json['controll'],
    );
  }

  static Map<String, dynamic> toJson(Schedule schedule) => {
        'dokter_id': schedule.idDokter,
        'pasien_id': schedule.idPasien,
        'nourut': schedule.noUrut,
        'jp': schedule.jenisPerawatan,
        'tanggal': schedule.tanggal,
      };

  static Map<String, dynamic> toJson2(Schedule schedule) => {
        'controll': schedule.controll,
        'catatan': schedule.catatan,
        'diagnosa': schedule.diagnosa,
      };
}
