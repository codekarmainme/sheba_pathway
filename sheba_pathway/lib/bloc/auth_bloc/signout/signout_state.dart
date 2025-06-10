import 'package:equatable/equatable.dart';

abstract class SignOutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutSuccess extends SignOutState {}

class SignOutFailure extends SignOutState {
  final String message;
  SignOutFailure(this.message);

  @override
  List<Object?> get props => [message];
}