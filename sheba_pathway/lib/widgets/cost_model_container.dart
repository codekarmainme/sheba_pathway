import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/cost_model/cost_model_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/cost_model/cost_model_event.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/cost_model/cost_model_state.dart';


class CostModelContainer extends StatelessWidget {
  const CostModelContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CostModelBloc, CostModelState>(
      builder: (context, state) {
        return Container(
          height: 35,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            itemCount: state.costModels.length,
            itemBuilder: (context, index) {
              final model = state.costModels[index];
              return GestureDetector(
                onTap: () {
                  context.read<CostModelBloc>().add(SetCostingModel(model));
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: state.selectedCostingModel['label'] == model['label']
                        ? secondaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        model['icon'],
                        color: black2,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}