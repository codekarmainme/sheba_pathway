import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sheba_pathway/bloc/current_location/current_location_bloc.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/main_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/current_location/current_location_event.dart';
import 'package:sheba_pathway/bloc/current_location/current_location_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<CurrentLocationBloc,CurrentLocationState>(
          listener: (context,state){
            if(state is CurrentLocationLoadingState){
              showDialog(
                context: context,
               barrierDismissible: false,
                builder: (BuildContext context) {
                  return Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      color: successColor,
                      secondRingColor: warningColor,
                      thirdRingColor: errorColor,
                      size: 50,
                    ),
                  );
                },
               );
            }
            if(state is CurrentLocationSuccessState){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavigator(currentPlaceName: state.placeName,)));
            }
            if(state is CurrentLocationErrorState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error,style: normalText.copyWith(color:errorColor),),
                )
              );
            }
          },
          builder: (context,state) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/tour with map.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.welcome_location_message,
                      style: mediumText.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      context.read<CurrentLocationBloc>().add(
                        DeterrminePositionEvent(context: context)
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 50,
                      child: Center(
                          child: Text(
                         AppLocalizations.of(context)!.allow_location,
                        style: mediumText.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  )
                ]);
          }
        ));
  }
}
