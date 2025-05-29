import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/hotel_picker_bloc/hotel_picker_bloc.dart';
import 'package:sheba_pathway/bloc/hotel_picker_bloc/hotel_picker_event.dart';
import 'package:sheba_pathway/bloc/hotel_picker_bloc/hotel_picker_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';

class HotelPickerDialog extends StatelessWidget {
  final double lat;
  final double lng;
  final int radius;

  const HotelPickerDialog({
    super.key,
    required this.lat,
    required this.lng,
    this.radius = 4000,
  });

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider.value(
      value: BlocProvider.of<HotelPickerBloc>(context)
        ..add(FetchHotels(lat: 9.3148, lng:lng, radius: radius)),
      child: AlertDialog(
        title: const Text('Select a Hotel'),
        content: SizedBox(
          width: double.maxFinite,
          child: BlocBuilder<HotelPickerBloc, HotelPickerState>(
            builder: (context, state) {
              if (state is HotelPickerLoading) {
                return Center(
                    child: LoadingAnimationWidget.discreteCircle(
                  color: successColor,
                  secondRingColor: warningColor,
                  thirdRingColor: errorColor,
                  size: 50,
                ));
              } else if (state is HotelPickerLoaded) {
                if (state.hotels.isEmpty) {
                  return const Text('No hotels found.');
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.hotels.length,
                  itemBuilder: (context, index) {
                    final hotel = state.hotels[index];
                    return ListTile(
                      title: Text(hotel['hotelName'],style: normalText,),
                      subtitle: Row(
                        children: [
                          Icon(Icons.location_on_outlined,size: 15,),
                          Text(hotel['hotelLocation'],style: smallText,),
                        ],
                      ),
                      leading: Icon(Icons.hotel_outlined,size: 15,),
                      onTap: () {
                        Navigator.of(context).pop(hotel);
                      },
                    );
                  },
                );
              } else if (state is HotelPickerError) {
                return Text('Error: ${state.message}');
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
