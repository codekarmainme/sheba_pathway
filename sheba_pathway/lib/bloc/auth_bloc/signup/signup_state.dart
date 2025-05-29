import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSucesss extends SignupState {}

class SignupError extends SignupState {
  final String error;
  SignupError(this.error);
  @override
  List<Object?> get props => [error];
}
