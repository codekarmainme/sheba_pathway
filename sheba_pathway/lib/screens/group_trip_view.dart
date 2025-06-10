import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/widgets/group_trip_discussion_widget.dart';

class GroupTripView extends StatefulWidget {
  const GroupTripView({
    super.key,
    required this.tripName,
    required this.tripAdress,
    required this.tripDesription,
    required this.tripImage,
    required this.percentFilled,
  });

  final String tripName;
  final String tripAdress;
  final String tripDesription;
  final String tripImage;
  final double percentFilled;

  @override
  State<GroupTripView> createState() => _GroupTripViewState();
}

class _GroupTripViewState extends State<GroupTripView> {
  int _currentImage = 0;
  late List<String> assetNames;

  @override
  void initState() {
    super.initState();
    assetNames = [
      widget.tripImage,
      widget.tripImage,
      widget.tripImage,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image carousel
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            PageView.builder(
                              itemCount: assetNames.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentImage = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: AssetImage(assetNames[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              top: 24,
                              left: 16,
                              right: 16,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Back button
                                  CircleAvatar(
                                    backgroundColor: Colors.black.withOpacity(0.5),
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_back, color: Colors.white),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                  // Place name
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          widget.tripName,
                                          style: GoogleFonts.sora(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            letterSpacing: 1,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.black.withOpacity(0.5),
                                    child: IconButton(
                                      icon: Icon(Icons.favorite_border, color: Colors.white),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  assetNames.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 3),
                                    width: _currentImage == index ? 12 : 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _currentImage == index
                                          ? primaryColor
                                          : Colors.white70,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.tripName,
                                  style: mediumText.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, color: black2.withOpacity(0.6)),
                                    Text(
                                      widget.tripAdress,
                                      style: normalText.copyWith(
                                          color: black2.withOpacity(0.6)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.add_task, color: Colors.white),
                              label: Text(
                                'Join',
                                style: normalText.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                elevation: 6,
                                shadowColor: primaryColor.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                textStyle: normalText.copyWith(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween<double>(
                                    begin: 0,
                                    end: widget.percentFilled,
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
                              "${(widget.percentFilled * 100).toInt()}%",
                              style: normalText.copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          widget.tripDesription,
                          style: normalText.copyWith(
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.justify,
                          selectionColor: successColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, color: black2.withOpacity(0.5)),
                                Text(
                                  '3 people going (2 people signed up)',
                                  style: normalText.copyWith(
                                      color: black2.withOpacity(0.6),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: black2.withOpacity(0.6),
                                ),
                                Text('Jun 25, 2025',
                                    style: normalText.copyWith(
                                        color: black2.withOpacity(0.6)))
                              ],
                            ),
                            Text(
                              "22 days left",
                              style: normalText.copyWith(color: black2.withOpacity(0.6)),
                            )
                          ],
                        ),
                      ),
                      // Discussion widget
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                        child: SizedBox(
                          height: 350, // Adjust as needed
                          child: GroupTripDiscussionWidget(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}