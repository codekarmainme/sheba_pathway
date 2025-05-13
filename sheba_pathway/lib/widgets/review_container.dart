import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/common/typography.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/pp.jpg"),
                    radius: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Joe Doe",
                        style: normalText.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Icon(
                            Icons.star_half,
                            color: Colors.amber,
                            size: 15,
                          )
                        ],
                      ),
                      Text(
                        "2025-02-08",
                        style: normalText,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                child: Text("I had a good time with this hotel in febrary. Good food, internet, tremodous customer service.",style: normalText,),
              )
            ],
          ),
        ));
  }
}
