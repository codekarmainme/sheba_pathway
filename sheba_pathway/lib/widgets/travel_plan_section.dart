import 'package:flutter/material.dart';
import 'package:sheba_pathway/widgets/travel_plan_container.dart';

class TravelPlanSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TravelPlanContainer(
          tripDestination: 'Dire Dawa old Metro',
          ispaid: false,
          tripDate: DateTime(2025, 06, 23),
          tripType: 'Solo trip',
          travelPlanID: 'difjdifjdif',
        ),
        TravelPlanContainer(
          tripDestination: 'Harar jegol wall',
          ispaid: true,
          tripDate: DateTime(2025, 05, 26),
          tripType: 'Family trip',
          travelPlanID: 'difjdifjdif',

        ),
        TravelPlanContainer(
          tripDestination: 'Haile selassie palace',
          ispaid: false,
          tripDate: DateTime(2025, 06, 10),
          tripType: 'Solo trip',
          travelPlanID: 'difjdifjdif',

        )
      ],
    );
  }
}
