import 'package:equatable/equatable.dart';
abstract class LoginState extends Equatable{
   @override
  List<Object?> get props => [];
}

class LoginIntialState extends LoginState{ 
}
class LoginloadingState extends LoginState{

}
class LoginSucessState extends LoginState{

}

class LoginErrorState extends LoginState{
  final String error;
  LoginErrorState(this.error);
  @override
  List<Object?> get props => [error];
}