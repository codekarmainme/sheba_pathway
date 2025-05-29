import 'package:equatable/equatable.dart';

abstract class CostModelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetCostingModel extends CostModelEvent {
  final Map<String, dynamic> costingModel;
  SetCostingModel(this.costingModel);

  @override
  List<Object?> get props => [costingModel];
}