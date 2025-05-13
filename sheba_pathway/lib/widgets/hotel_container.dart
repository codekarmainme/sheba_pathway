import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/provider/mapping_provider.dart';
import 'package:sheba_pathway/screens/map_screen.dart';
import 'package:sheba_pathway/widgets/review_container.dart';
import 'package:url_launcher/url_launcher.dart';
class HotelContainer extends StatefulWidget {
  const HotelContainer(
      {super.key,
      required this.name,
      required this.location,
      required this.distnce,
      required this.time,
      required this.lat,
      required this.long,
      required this.phoneNumber
      });
  final String name;
  final String location;
  final String distnce;
  final String time;
  final double lat;
  final double long;
  final String phoneNumber;
  @override
  State<HotelContainer> createState() => _HotelContainerState();
}

class _HotelContainerState extends State<HotelContainer> {
  bool isFavorited = false;
  bool isSeeMore = false;
  void setisFavorited() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  void setisSeeMore() {
    setState(() {
      isSeeMore = !isSeeMore;
    });
  }
  void _makePhonecall(String phoneNumber) async{
    final Uri phoneUri=Uri(scheme: 'tel', path: phoneNumber);
    if(await canLaunchUrl(phoneUri)){
      await launchUrl(phoneUri);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch dialer",style: normalText,),)
      );
    }
  }
  @override
  Widget build(BuildContext context) {
  final mappingProvider=Provider.of<MappingProvider>(context,listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: mediumText.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/fries.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/Orange.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10)),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                        ),
                        Text(
                          widget.location,
                          style: normalText.copyWith(),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 15),
                    Text(
                      "4.5(5 reviews)",
                      style: normalText.copyWith(),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.taxi,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.distnce,
                      style: normalText,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                            color: black2, shape: BoxShape.circle),
                      ),
                    ),
                    Text(
                      widget.time,
                      style: normalText,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: isFavorited
                      ? GestureDetector(
                          onTap: setisFavorited,
                          child: Icon(
                            FontAwesomeIcons.solidHeart,
                            size: 15,
                            color: Colors.red,
                          ),
                        )
                      : GestureDetector(
                          onTap: setisFavorited,
                          child: Icon(
                            FontAwesomeIcons.heart,
                            size: 15,
                          ),
                        ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Row(
                children: [
                  _button('Start', Icons.navigation, () {
                    print(mappingProvider.selectedStartlocation);
                    print("${[widget.lat,widget.long]} hotel adress");
                    mappingProvider.setselectedDestinationLocation([
                      {
                      "name":widget.name,
                      },
                      {
                        'coordinates':[widget.lat,widget.long]
                      }
                    ]);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen()));
                  }),
                  SizedBox(width: 5,),
                  _button('Call', Icons.phone,(){
                    _makePhonecall(widget.phoneNumber);
                  })
                ],
              ),
            ),
            if (isSeeMore)
              Column(
                children: [
                  ReviewContainer(),
                  ReviewContainer(),
                ],
              ),
            TextButton.icon(
              onPressed: setisSeeMore,
              label: Text(
                isSeeMore ? "See less" : 'See more',
                style: normalText.copyWith(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _button(String txt, IconData icon, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 15,
              ),
              Text(
                txt,
                style: normalText.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: black2, width: 2)),
      ),
    );
  }
}
