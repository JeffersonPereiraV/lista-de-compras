import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:soft_list/blocs/user/user_bloc.dart';
import 'package:soft_list/models/user.dart';
import 'package:soft_list/repositories/storage_repository.dart';

import 'user_bloc_test.mocks.dart';

@GenerateMocks([StorageRepository])
void main() {
  late UserBloc userBloc;
  late MockStorageRepository mockRepository;

  setUp(() {
    mockRepository = MockStorageRepository();
    userBloc = UserBloc(mockRepository);
  });

  tearDown(() {
    userBloc.close();
  });

  group('UserBloc', () {
    const user = User(name: 'Usuário', currency: 'BRL');

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when LoadUser succeeds',
      build: () {
        when(mockRepository.loadUser()).thenAnswer((_) async => user);
        return userBloc;
      },
      act: (bloc) => bloc.add(const LoadUser()),
      expect: () => [const UserLoading(), const UserLoaded(user)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserError] when LoadUser fails',
      build: () {
        when(mockRepository.loadUser()).thenThrow(Exception('Load error'));
        return userBloc;
      },
      act: (bloc) => bloc.add(const LoadUser()),
      expect:
          () => [const UserLoading(), const UserError('Exception: Load error')],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserError] when UpdateUser has invalid currency',
      build: () => userBloc,
      act: (bloc) => bloc.add(const UpdateUser('João', 'GBP')),
      expect: () => [const UserError('Invalid currency')],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when UpdateUser succeeds',
      build: () {
        when(mockRepository.saveUser(any)).thenAnswer((_) async {});
        return userBloc;
      },
      act: (bloc) => bloc.add(const UpdateUser('João', 'USD')),
      expect:
          () => [
            const UserLoading(),
            const UserLoaded(User(name: 'João', currency: 'USD')),
          ],
    );
  });
}
