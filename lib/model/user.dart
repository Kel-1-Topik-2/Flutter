class User {
  String? username;
  String? password;
  String? role;
  String? token;

  User({
    this.username,
    this.password,
    this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
    );
  }

  factory User.fromJson2(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
    );
  }

  static Map<String, dynamic> toJson(User user) {
    String? role;
    if (user.role == 'Admin') {
      role = 'ROLE_ADMIN';
    }
    if (user.role == 'Doctor') {
      role = 'ROLE_DOKTER';
    }
    return {
      'username': user.username,
      'password': user.password,
      'role': role,
    };
  }
}
