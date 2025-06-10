import 'package:flutter/material.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/setting_screen.dart';
import 'package:sheba_pathway/widgets/history_section.dart';
import 'package:sheba_pathway/widgets/review_section.dart';
import 'package:sheba_pathway/widgets/saved_section.dart';
import 'package:sheba_pathway/widgets/travel_plan_section.dart';

class YouScreen extends StatefulWidget {
  const YouScreen({super.key});

  @override
  State<YouScreen> createState() => _YouScreenState();
}

class _YouScreenState extends State<YouScreen> {
  List<Map<String, dynamic>> _catagories = [
    {"name": 'History', 'section': HistorySection()},
    {"name": 'Saved', 'section': SavedSection()},
    {"name": 'Travel plans', 'section': TravelPlanSection()},
    {"name": 'Reviewed', 'section': ReviewSection()}
  ];
  late Map<String, dynamic> _selectedCatagory;
  void setSelectedCatagory(Map<String, dynamic> catagory) {
    setState(() {
      _selectedCatagory = catagory;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedCatagory = {"name": 'History', 'section': HistorySection()};
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              "Profile",
              style: largeText.copyWith(
                  color: black2, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingScreen()));
              },
              icon: Icon(Icons.settings, color:  black2.withOpacity(0.5)),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/pp.jpg"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: whiteColor, // Background color for the icon
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: black2,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Joe Doe",
                style: normalText.copyWith(
                    color: black2, fontWeight: FontWeight.bold),
              ),
              Text(
                "Traveler",
                style: normalText.copyWith(color: black2.withOpacity(0.8)),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _contributeTypeContainer("Hotel", Icons.hotel),
                    _contributeTypeContainer("Home", Icons.home),
                    _contributeTypeContainer(
                        "Travel destination", Icons.add_location),
                    _contributeTypeContainer(
                        "Update places", Icons.edit_location),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _catagories.map((catagory) {
                  return GestureDetector(
                    onTap: () {
                      setSelectedCatagory(catagory);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: catagory == _selectedCatagory
                            ? Border(
                                bottom: BorderSide(
                                  color: successColor,
                                  width: 3,
                                ),
                              )
                            : null,
                      ),
                      child: Text(
                        catagory['name'],
                        style: normalText.copyWith(
                            color:  black2, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }).toList(),
              ),
              Divider(),
              SizedBox(height: 400, child: _selectedCatagory['section'])
            ],
          ),
        ),
      ),
    );
  }

  Widget _contributeTypeContainer(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: successColor, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 16,
                      ),
                    )),
                Text(text,
                    style: smallText.copyWith(
                        color: black2, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
