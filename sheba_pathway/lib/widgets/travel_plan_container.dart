import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/payment_bloc/payment_blocs.dart';
import 'package:sheba_pathway/bloc/payment_bloc/payment_events.dart';
import 'package:sheba_pathway/bloc/payment_bloc/payment_states.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:intl/intl.dart';
import 'package:sheba_pathway/screens/travel_assist_screen.dart';

class TravelPlanContainer extends StatefulWidget {
  final String tripDestination;
  final DateTime tripDate;
  final String tripType;
  final bool ispaid;
  final String travelPlanID;
  const TravelPlanContainer({
    Key? key,
    required this.tripDestination,
    required this.tripDate,
    required this.tripType,
    required this.ispaid,
    required this.travelPlanID,
  });

  @override
  State<TravelPlanContainer> createState() => _TravelPlanContainerState();
}

class _TravelPlanContainerState extends State<TravelPlanContainer> {
  String generateTxRef() {
    final now = DateTime.now();
    final random = Random();
    return 'txn_${now.millisecondsSinceEpoch}_${random.nextInt(99999)}';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.flight_takeoff,
                                color: primaryColor, size: 22),
                            Text(
                              widget.tripDestination,
                              style: normalText.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.calendar_month,
                                size: 16, color: black2.withOpacity(0.5)),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('EEE, M/d/y').format(widget.tripDate),
                              style: smallText.copyWith(
                                  color: black2.withOpacity(0.6)),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.timelapse,
                                size: 16, color: black2.withOpacity(0.5)),
                            const SizedBox(width: 4),
                            Text(
                              () {
                                final now = DateTime.now();
                                final tripDate = widget.tripDate;
                                final daysLeft = tripDate
                                    .difference(
                                        DateTime(now.year, now.month, now.day))
                                    .inDays;
                                if (daysLeft > 0) {
                                  return "$daysLeft day${daysLeft == 1 ? '' : 's'} left";
                                } else if (daysLeft == 0) {
                                  return "Trip is today";
                                } else {
                                  return "Trip passed";
                                }
                              }(),
                              style: smallText.copyWith(
                                color: black2.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.person,
                                size: 16, color: black2.withOpacity(0.5)),
                            const SizedBox(width: 4),
                            Text(
                              widget.tripType,
                              style: smallText.copyWith(
                                  color: black2.withOpacity(0.6)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.edit, size: 18, color: primaryColor),
                      label: Text(
                        "Edit",
                        style: normalText.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        widget.ispaid
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TravelAssistScreen()))
                            : context.read<PaymentBloc>().add(StartPayment(
                                context: context,
                                amount: 100,
                                email: 'miki@gmail.com',
                                phone: '098765434567',
                                firstName: 'Miki',
                                lastName: 'Shibabaw',
                                txRef: generateTxRef(),
                                title: 'Order payment',
                                desc: 'Order no -08733 travel trip payment',
                                id: widget.travelPlanID
                                ));
                      },
                      child: Text(
                        widget.ispaid ? 'Start' : "Checkout",
                        style: normalText.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            widget.ispaid ? successColor : primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
