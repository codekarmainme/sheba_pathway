import 'package:equatable/equatable.dart';
abstract class LoginEvent extends Equatable {
@override
 List<Object?> get props =>[];
}
class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;
  LoginSubmitEvent(this.email, this.password);
  @override
  List<Object?> get props => [email,password];
}

class SigninWithGoogle extends LoginEvent{}
class SigninWithFacebook extends LoginEvent{}