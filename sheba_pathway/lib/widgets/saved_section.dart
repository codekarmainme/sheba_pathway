import 'package:flutter/material.dart';
import 'package:sheba_pathway/widgets/group_trip_container.dart';

class SavedSection extends StatelessWidget {
  const SavedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GroupTripContainer(assetName: "assets/images/Midr babur.png", locaition: "Dire Dawa", price: "1000", placeName: "Old metro",percentFilled: 50,)
      ],
    );
  }
}