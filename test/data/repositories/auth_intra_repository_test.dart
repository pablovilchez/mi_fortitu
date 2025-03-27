import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_intra_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'package:mi_fortitu/features/auth/data/repositories/auth_intra_repository_impl.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';

import '../datasources/auth_intra_datasource_test.dart';

class MockIntraAuthDatasource extends Mock implements AuthIntraDatasource {}

void main() {
  late AuthIntraRepository repository;
  late MockIntraAuthDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockIntraAuthDatasource();
    repository = AuthIntraRepositoryImpl(mockDatasource);
  });

  test('Returns a valid OAuth2 client if tokens are already stored', () async {
    when(() => mockDatasource.getIntraClient()).thenAnswer((_) async => Future.value(MockOauth2Client()));

    final result = await repository.getIntraClient();

    expect(result, isA<Right>());
    verify(() => mockDatasource.getIntraClient()).called(1);
  });

  test('Returns a Failure when the datasource throws an error', () async {
    when(() => mockDatasource.getIntraClient()).thenThrow(Exception('Authentication failed'));

    final result = await repository.getIntraClient();

    expect(result, isA<Left>());
    expect((result as Left).value, isA<IntraLoginFailure>());
  });
}
