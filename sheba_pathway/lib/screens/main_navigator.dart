import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/bloc/hotel_bloc/all_hotels_widget/all_hotels_bloc.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/repository/hotel_repository.dart';
import 'package:sheba_pathway/screens/blog_screen.dart';
import 'package:sheba_pathway/screens/home_screen.dart';
import 'package:sheba_pathway/screens/hotel_screen.dart';
import 'package:sheba_pathway/screens/map_screen.dart';
import 'package:sheba_pathway/screens/you_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key, required this.currentPlaceName});
  final String currentPlaceName;
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: GNav(
          curve: Curves.bounceIn,
          gap: 4,
          duration: Duration(milliseconds: 900),
          backgroundColor: Colors.white,
          color: primaryColor,
          activeColor: successColor,
          tabActiveBorder: Border.all(color: successColor, width: 2),
          tabBackgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          iconSize: 20,
          tabMargin: EdgeInsets.all(4),
          selectedIndex: _currentpage,
          onTabChange: (index) {
            setState(() {
              _currentpage = index;
            });
          },
          tabs: [
            GButton(
              icon: FontAwesomeIcons.house,
              text: 'Home',
            ),
            GButton(
              icon: FontAwesomeIcons.bed,
              text: 'Hotels',
            ),
            GButton(
              icon: FontAwesomeIcons.locationDot,
              text: 'Map',
            ),
            GButton(
              icon: Icons.article,
              text: 'Blogs',
            ),
            GButton(
              icon: FontAwesomeIcons.solidUser,
              text: 'You',
            ),
          ],
        ),
      ),
      body: _getBody(_currentpage),
    );
  }

  Widget _getBody(int page) {
    switch (page) {
      case 0:
        return HomeScreen(
          currentPlaceName: widget.currentPlaceName,
        );
      case 1:
        return BlocProvider(
          create: (context) => AllHotelsBloc(HotelRepository()),
          child: HotelScreen(),
        );
      case 2:
        return const MapScreen();
      case 3:
        return BlogScreen();
      case 4:
        return const YouScreen();
      default:
        return HomeScreen(currentPlaceName: widget.currentPlaceName);
    }
  }
}
