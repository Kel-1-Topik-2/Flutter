import 'package:flutter_test/flutter_test.dart';
import 'package:hospital/model/api/user_api.dart';
import 'package:hospital/model/doctor.dart';
import 'package:hospital/model/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_api_test.mocks.dart';

@GenerateMocks([UserAPI])
void main() {
  UserAPI userAPI = MockUserAPI();

  User userAdmin = User(
    username: 'admin123',
    password: 'admin123',
    role: 'ROLE_ADMIN',
  );

  User userDokter = User(
    username: 'aaaaaaaa',
    password: 'aaaaaaaa',
    role: 'ROLE_DOKTER',
  );

  group('User API', () {
    test('login admin', () async {
      when(userAPI.login(userAdmin)).thenAnswer((_) async =>
          'eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxNCIsInN1YiI6ImFhYWFhYWFhIn0.XGh-SQ97I1adGRcnRdoV_CYUuXW2ZdM_uqegtR0EsDg');
      String? token = await userAPI.login(userAdmin);
      expect(token!.isEmpty, false);
    });

    test('login dokter', () async {
      when(userAPI.login(userDokter)).thenAnswer((_) async =>
          'eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxMyIsInN1YiI6ImFkbWluMTIzIn0.IyDgsDjLlR8REzrQepn3RMpZIcLmfh_mVARhN6ZTwDU');
      String? token = await userAPI.login(userDokter);
      expect(token!.isEmpty, false);
    });

    test('get data dokter', () async {
      when(userAPI.getDoctor()).thenAnswer(
        (_) async => Doctor(
          id: 8,
          namaLengkap: 'aaaa',
          spesialis: 'aa',
          npa: 1111111,
          username: 'aaaaaaaa',
          password: 'aaaaaaaa',
        ),
      );
      var doctor = await userAPI.getDoctor();
      expect(
        doctor,
        Doctor(
          id: 8,
          namaLengkap: 'aaaa',
          spesialis: 'aa',
          npa: 1111111,
          username: 'aaaaaaaa',
          password: 'aaaaaaaa',
        ),
      );
    });
  });
}
