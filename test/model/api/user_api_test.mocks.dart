// Mocks generated by Mockito 5.2.0 from annotations
// in hospital/test/model/api/user_api_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dio/dio.dart' as _i2;
import 'package:hospital/model/api/token.dart' as _i3;
import 'package:hospital/model/api/user_api.dart' as _i4;
import 'package:hospital/model/doctor.dart' as _i7;
import 'package:hospital/model/user.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeDio_0 extends _i1.Fake implements _i2.Dio {}

class _FakeToken_1 extends _i1.Fake implements _i3.Token {}

/// A class which mocks [UserAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserAPI extends _i1.Mock implements _i4.UserAPI {
  MockUserAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get dio =>
      (super.noSuchMethod(Invocation.getter(#dio), returnValue: _FakeDio_0())
          as _i2.Dio);
  @override
  set dio(_i2.Dio? _dio) => super.noSuchMethod(Invocation.setter(#dio, _dio),
      returnValueForMissingStub: null);
  @override
  _i3.Token get token => (super.noSuchMethod(Invocation.getter(#token),
      returnValue: _FakeToken_1()) as _i3.Token);
  @override
  set token(_i3.Token? _token) =>
      super.noSuchMethod(Invocation.setter(#token, _token),
          returnValueForMissingStub: null);
  @override
  _i5.Future<String?> login(_i6.User? user) =>
      (super.noSuchMethod(Invocation.method(#login, [user]),
          returnValue: Future<String?>.value()) as _i5.Future<String?>);
  @override
  _i5.Future<_i7.Doctor?> getDoctor() =>
      (super.noSuchMethod(Invocation.method(#getDoctor, []),
          returnValue: Future<_i7.Doctor?>.value()) as _i5.Future<_i7.Doctor?>);
}
