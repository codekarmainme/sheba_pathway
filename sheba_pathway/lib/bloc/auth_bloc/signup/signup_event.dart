import 'package:equatable/equatable.dart';
abstract class SignupEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class SignupSubmit extends SignupEvent{
  final String email;
  final String password;
  SignupSubmit(this.email, this.password);
  @override
  List<Object?> get props => [email,password];
}