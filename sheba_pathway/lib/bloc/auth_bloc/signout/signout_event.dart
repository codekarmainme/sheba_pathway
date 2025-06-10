import 'package:equatable/equatable.dart';

abstract class SignOutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignOutRequested extends SignOutEvent {}
