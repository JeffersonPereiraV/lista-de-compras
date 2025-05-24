import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_list/models/user.dart';
import 'package:soft_list/repositories/storage_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final StorageRepository storageRepository;

  UserBloc(this.storageRepository) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await storageRepository.loadUser();
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('Failed to load user: $e'));
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    try {
      await storageRepository.saveUser(event.user);
      emit(UserLoaded(event.user));
    } catch (e) {
      emit(UserError('Failed to update user: $e'));
    }
  }
}
