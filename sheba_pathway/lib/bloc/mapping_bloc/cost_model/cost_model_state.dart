import 'package:equatable/equatable.dart';

class CostModelState extends Equatable {
  final List<Map<String, dynamic>> costModels;
  final Map<String, dynamic> selectedCostingModel;

  const CostModelState({
    required this.costModels,
    required this.selectedCostingModel,
  });

  CostModelState copyWith({
    List<Map<String, dynamic>>? costModels,
    Map<String, dynamic>? selectedCostingModel,
  }) {
    return CostModelState(
      costModels: costModels ?? this.costModels,
      selectedCostingModel: selectedCostingModel ?? this.selectedCostingModel,
    );
  }

  @override
  List<Object?> get props => [costModels, selectedCostingModel];
}