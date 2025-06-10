import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signup/signup_event.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signup/signup_state.dart';
import 'package:sheba_pathway/repository/auth_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>{
  final AuthRepository authRepository;
  SignupBloc(this.authRepository):super(SignupInitial()){
    on<SignupSubmit>((event, emit)async{
      emit(SignupLoading());
    try{
      await authRepository.signup(email: event.email,password: event.password,username: event.username);
      emit(SignupSucesss());
    }
    catch(e){
      emit(SignupError(e.toString()));
    }
    });
  }
}