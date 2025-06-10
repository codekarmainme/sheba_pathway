import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sheba_pathway/bloc/travel_plans_bloc/travel_plans_bloc.dart';
import 'package:sheba_pathway/bloc/travel_plans_bloc/travel_plans_event.dart';
import 'package:sheba_pathway/bloc/travel_plans_bloc/travel_plans_state.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/widgets/travel_plan_container.dart';
import 'package:sheba_pathway/widgets/error_container.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AddedTravelPlans extends StatefulWidget {
  const AddedTravelPlans({super.key});

  @override
  State<AddedTravelPlans> createState() => _AddedTravelPlansState();
}

class _AddedTravelPlansState extends State<AddedTravelPlans> {
  int _selectedTab = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Travel plans",
                style: largeText.copyWith(
                    color: black2, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(backgroundImage: AssetImage("assets/images/pp.jpg")),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              gap: 8,
              backgroundColor: Colors.transparent,
              color: black2,
              activeColor: successColor,
              tabBorder: Border.all(color: successColor, width: 2),
              tabActiveBorder: Border.all(color: successColor, width: 2),
              tabBackgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              selectedIndex: _selectedTab,
              onTabChange: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
              tabs: [
                GButton(
                  icon: Icons.check_circle_outline,
                  text: 'Ready to go',
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Want to go',
                ),
              ],
            ),
          ),
          BlocProvider.value(
            value: BlocProvider.of<TravelPlansBloc>(context)
              ..add(LoadTravelPlans()),
            child: BlocBuilder<TravelPlansBloc, TravelPlansState>(
              builder: (context, state) {
                if (state is TravelPlansLoading) {
                  return Expanded(
                    child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: successColor,
                        secondRingColor: warningColor,
                        thirdRingColor: errorColor,
                        size: 50,
                      ),
                    ),
                  );
                }
                if (state is TravelPlansError) {
                  return ErrorContainer(
                    title: 'Error',
                    message: state.message,
                    retryCallback: () {
                      context.read<TravelPlansBloc>().add(LoadTravelPlans());
                    },
                  );
                }
                if (state is TravelPlansLoaded) {
                  return Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: state.plans.map((travelPlan) {
                        return TravelPlanContainer(
                          tripDestination: travelPlan.destinationName,
                          tripDate: travelPlan.tripDate,
                          tripType: 'Solo trip',
                          ispaid: travelPlan.isPaid,
                          travelPlanID: travelPlan.id!,
                        );
                      }).toList(),
                    ),
                  ));
                }
                return Center(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.error,
                              size: 20,
                            ),
                            Text(
                              "Error",
                              style: normalText,
                            )
                          ],
                        ),
                        Text(
                          "Please wait some minutes",
                          style: smallText,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
