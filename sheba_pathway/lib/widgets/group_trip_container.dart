import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';

class GroupTripContainer extends StatelessWidget {
  const GroupTripContainer(
      {super.key,
      required this.assetName,
      required this.locaition,
      required this.price,
      required this.placeName});
  final String assetName;
  final String locaition;
  final String price;
  final String placeName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(assetName), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mountain Trip",
                    style:normalText.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(placeName,
                      style: normalText.copyWith(
                          color: Colors.black.withOpacity(0.5))),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.black.withOpacity(0.5),
                        size: 15,
                      ),
                      Text(
                        locaition,
                        style: normalText.copyWith(
                            color: Colors.black.withOpacity(0.5)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price,
                          style: normalText.copyWith(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Text("50%",
                          style: normalText.copyWith(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
