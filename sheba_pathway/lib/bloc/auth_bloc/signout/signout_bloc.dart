import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signout/signout_event.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signout/signout_state.dart';
import 'package:sheba_pathway/repository/auth_repository.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  final AuthRepository auth;

  SignOutBloc(this.auth) : super(SignOutInitial()) {
    on<SignOutRequested>((event, emit) async {
      emit(SignOutLoading());
      try {
        await auth.signOut();
        emit(SignOutSuccess());
      } catch (e) {
        emit(SignOutFailure(e.toString()));
      }
    });
  }
}