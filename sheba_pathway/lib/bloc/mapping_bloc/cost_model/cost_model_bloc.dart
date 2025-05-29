import 'package:flutter_bloc/flutter_bloc.dart';
import 'cost_model_event.dart';
import 'cost_model_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CostModelBloc extends Bloc<CostModelEvent, CostModelState> {
  CostModelBloc()
      : super(CostModelState(
          costModels: [
            {'label': 'Taxi', 'icon': FontAwesomeIcons.taxi, 'action': "Drive"},
            {'label': 'Pedestrian', 'icon': FontAwesomeIcons.personWalking, 'action': "Walk"},
            {'label': 'Bus', 'icon': FontAwesomeIcons.bus, "action": "Public transport"},
          ],
          selectedCostingModel: {'label': 'Taxi', 'icon': FontAwesomeIcons.taxi, 'action': "Drive"},
        )) {
    on<SetCostingModel>((event, emit) {
      emit(state.copyWith(selectedCostingModel: event.costingModel));
    });
  }
}