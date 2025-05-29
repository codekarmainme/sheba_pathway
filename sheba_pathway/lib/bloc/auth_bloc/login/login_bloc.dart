import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/auth_bloc/login/login_event.dart';
import 'package:sheba_pathway/bloc/auth_bloc/login/login_state.dart';
import 'package:sheba_pathway/repository/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc(this.authRepository) : super(LoginIntialState()) {
    on<LoginSubmitEvent>((event, emit) async {
      emit(LoginloadingState());
      try {
        await authRepository.signin(
            email: event.email, password: event.password);
        emit(LoginSucessState());
      } catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
  }
}
