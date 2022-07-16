class Patient {
  int? id;
  int? nik;
  int? usia;
  int? telp;
  String? namaLengkap;
  String? jk;
  String? alamat;

  Patient({
    this.id,
    this.namaLengkap,
    this.nik,
    this.usia,
    this.jk,
    this.telp,
    this.alamat,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      namaLengkap: json['namapasien'],
      nik: json['nik'],
      usia: json['umur'],
      jk: json['jeniskelamin'],
      telp: json['telp'],
      alamat: json['alamat'],
    );
  }

  static Map<String, dynamic> toJson(Patient itemProject) => {
        'idPasien': itemProject.id,
        'namapasien': itemProject.namaLengkap,
        'nik': itemProject.nik,
        'umur': itemProject.usia.toString(),
        'jeniskelamin': itemProject.jk,
        'telp': itemProject.telp,
        'alamat': itemProject.alamat,
      };
}
