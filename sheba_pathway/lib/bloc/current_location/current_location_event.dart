import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
abstract class CurrentLocationEvent extends Equatable{
  @override
  List<Object?> get props => [];

}
class DeterrminePositionEvent extends CurrentLocationEvent{
  final BuildContext context;
  DeterrminePositionEvent({required this.context});
}

