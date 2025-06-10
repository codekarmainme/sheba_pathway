import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:sheba_pathway/bloc/travel_plans_bloc/travel_plans_event.dart';
import 'package:sheba_pathway/bloc/travel_plans_bloc/travel_plans_state.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/bloc/travel_plans_bloc/travel_plans_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/models/travel_plan_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sheba_pathway/widgets/hotel_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddSheet extends StatefulWidget {
  const AddSheet(
      {Key? key, required this.lat, required this.lng, required this.tripName})
      : super(key: key);
  final double lat;
  final double lng;
  final String tripName;
  @override
  State<AddSheet> createState() => _AddSheetState();
}

class _AddSheetState extends State<AddSheet> {
  TextEditingController datecontroller = TextEditingController();
  TextEditingController hotelcontroller = TextEditingController();
  TextEditingController nooftravelerscontroller = TextEditingController();
  TextEditingController tripdurationcontroller = TextEditingController();
  TextEditingController budgetcontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController purposeoftripcontroller = TextEditingController();
  DateTime? _tripDate;
  LatLng? selectedhotelCoordinate;
  Future<void> _selectTripDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(20101));
    if (picked != null && picked != _tripDate) {
      setState(() {
        setState(() {
          datecontroller.text =
              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
          print(datecontroller.text);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TravelPlansBloc, TravelPlansState>(
        listener: (context, state) {
      if (state is TravelPlansAdding) {
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
      } else {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
      if (state is TravelPlanAdded) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'The trip plan is added successfully',
            style: normalText.copyWith(color: successColor),
          ),
        ));

        Navigator.of(context).pop();
      }
      if (state is TravelPlansAddingError) {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            state.message,
            style: normalText.copyWith(color: errorColor),
          ),
        ));
      }
    }, builder: (context, state) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selassie house view",
                    style: mediumText.copyWith(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: IntlPhoneField(
                        controller: phonenumbercontroller,
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          labelStyle: normalText,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'ET',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                    ),
                  ),
                  _textfield(
                    "Pick a trip date",
                    () {
                      _selectTripDate(context);
                    },
                    datecontroller,
                    true,
                    Icons.calendar_today,
                    TextInputType.datetime,
                  ),
                  _textfield(
                    "Pick hotel on destination",
                    () async {
                      final selectedHotel =
                          await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (context) => HotelPickerDialog(
                          lat: widget
                              .lat, // Replace with your destination's latitude
                          lng: widget
                              .lng, // Replace with your destination's longitude
                          radius: 10000,
                        ),
                      );
                      if (selectedHotel != null) {
                        setState(() {
                          hotelcontroller.text = selectedHotel['hotelName'];
                          selectedhotelCoordinate =
                              selectedHotel['hotelCoordinate'];
                        });
                      }
                    },
                    hotelcontroller,
                    true,
                    Icons.hotel,
                    TextInputType.text,
                  ),
                  _textfield(
                    "Number of travels",
                    () {},
                    nooftravelerscontroller,
                    false,
                    Icons.people,
                    TextInputType.number,
                  ),
                  _textfield(
                      "Trip duration (days)",
                      () {},
                      tripdurationcontroller,
                      false,
                      Icons.timer,
                      TextInputType.number),
                  _textfield("Budget", () {}, budgetcontroller, false,
                      Icons.attach_money, TextInputType.number),
                  _textfield(
                      "Purpose of trip i.e buisness,",
                      () {},
                      purposeoftripcontroller,
                      false,
                      Icons.work,
                      TextInputType.text),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Wish list',
                        style: normalText.copyWith(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user == null) {
                          // Handle not logged in
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  'You must be logged in to add a trip plan.',
                                  style: normalText.copyWith(color: errorColor),
                                )),
                          );
                          return;
                        }
                        if (datecontroller.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Please select a trip date',
                                    style: normalText.copyWith(
                                        color: errorColor))),
                          );
                          return;
                        }
                        if (phonenumbercontroller.text.isEmpty ||
                            phonenumbercontroller.text.length < 9) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  'Please enter a valid phone number',
                                  style: normalText.copyWith(color: errorColor),
                                )),
                          );
                          return;
                        }

                        final plan = TripPlanModel(
                            userId: user.uid,
                            destinationName: widget.tripName,
                            tripDate: DateTime.parse(datecontroller.text),
                            hotel: hotelcontroller.text,
                            numberOfTravellers:
                                int.tryParse(nooftravelerscontroller.text) ?? 1,
                            tripDuration:
                                int.tryParse(tripdurationcontroller.text) ?? 1,
                            budget:
                                double.tryParse(budgetcontroller.text) ?? 0.0,
                            phoneNumber: phonenumbercontroller.text,
                            purposeOfTrip: purposeoftripcontroller.text,
                            isPaid: false,
                            hotelCoordinate: selectedhotelCoordinate ??
                                LatLng(widget.lat, widget.lng));

                        context
                            .read<TravelPlansBloc>()
                            .add(AddTravelPlan(plan));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 2,
                      ),
                      child: Text(
                        'Done',
                        style: normalText.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _textfield(
      String hinttxt,
      VoidCallback onTap,
      TextEditingController controller,
      bool readOnly,
      IconData icon,
      TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              size: 15,
            ),
            contentPadding: const EdgeInsets.all(8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(width: 1, color: black2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(width: 1, color: black2),
            ),
            hintText: hinttxt,
          ),
          controller: controller,
          style: normalText,
        ),
      ),
    );
  }
}
