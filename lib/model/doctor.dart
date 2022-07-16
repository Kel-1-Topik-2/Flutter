class Doctor {
  int? id;
  int? npa;
  int? idUsername;
  String? namaLengkap;
  String? spesialis;
  String? username;
  String? password;

  Doctor({
    this.id,
    this.idUsername,
    this.username,
    this.password,
    this.namaLengkap,
    this.spesialis,
    this.npa,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      idUsername: json['user']['id'],
      namaLengkap: json['namadokter'],
      spesialis: json['spesialis'],
      npa: json['srp'],
      username: json['user']['username'],
      password: json['user']['password'],
    );
  }

  factory Doctor.fromJson2(Map<String, dynamic> json) {
    return Doctor(
      idUsername: json['user_id'],
      namaLengkap: json['namadokter'],
      spesialis: json['spesialis'],
      npa: json['srp'],
      username: json['username'],
      password: json['password'],
    );
  }

  static Map<String, dynamic> toJson(Doctor doctor) => {
        "user_id": doctor.idUsername,
        "namadokter": doctor.namaLengkap,
        "spesialis": doctor.spesialis,
        "srp": doctor.npa,
        'username': doctor.username,
        'password': doctor.password,
      };

  static Map<String, dynamic> toJsonDokter(Doctor itemProject, int userId) => {
        "user_id": userId,
        "namadokter": itemProject.namaLengkap,
        "spesialis": itemProject.spesialis,
        "srp": itemProject.npa,
      };

  static Map<String, dynamic> toJsonUser(Doctor itemProject) => {
        'username': itemProject.username,
        'password': itemProject.password,
      };
}
