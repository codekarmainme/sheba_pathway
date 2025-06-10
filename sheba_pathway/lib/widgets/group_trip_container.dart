import 'package:flutter/material.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/group_trip_view.dart';

class GroupTripContainer extends StatelessWidget {
  const GroupTripContainer({
    super.key,
    required this.assetName,
    required this.locaition,
    required this.price,
    required this.placeName,
    required this.percentFilled, // Add this parameter
  });

  final String assetName;
  final String locaition;
  final String price;
  final String placeName;
  final double percentFilled; // e.g., 0.5 for 50%

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupTripView(
                        tripName: placeName,
                        tripAdress: locaition,
                        tripDesription:
                            "Join fellow explorers on an unforgettable group journey to the breathtaking Simien Mountains! Experience dramatic landscapes, unique wildlife, and vibrant local culture. This trip includes guided hikes, camping under the stars, and visits to iconic viewpoints. ",
                        tripImage: assetName,
                        percentFilled: percentFilled,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Trip image
              ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(16)),
                child: Image.asset(
                  assetName,
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // Trip details
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mountain Trip",
                        style: normalText.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        placeName,
                        style: normalText.copyWith(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.black.withOpacity(0.5),
                            size: 15,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              locaition,
                              style: normalText.copyWith(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Progress bar and percent
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween<double>(
                                    begin: 0,
                                    end: percentFilled,
                                  ),
                                  duration: const Duration(milliseconds: 1500),
                                  curve: Curves.easeOutCubic,
                                  builder: (context, value, child) {
                                    return LinearProgressIndicator(
                                      value: value,
                                      minHeight: 5,
                                      backgroundColor: grey1,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(successColor),
                                    );
                                  },
                                ),
                              ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${(percentFilled * 100).toInt()}%",
                            style: normalText.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Price
                      Text(
                        price,
                        style: normalText.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
