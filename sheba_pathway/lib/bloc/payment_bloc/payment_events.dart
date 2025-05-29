import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PaymentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartPayment extends PaymentEvent {
  final BuildContext context;
  final double amount;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String txRef;
  final String title;
  final String desc;
  final String id;
  StartPayment({
    required this.context,
    required this.amount,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.txRef,
    required this.title,
    required this.desc,
    required this.id
  });

  @override
  List<Object?> get props => [context,amount, email, phone, firstName, lastName, txRef, title, desc];
}