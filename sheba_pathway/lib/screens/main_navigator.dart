import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sheba_pathway/screens/home_screen.dart';
import 'package:sheba_pathway/screens/hotel_screen.dart';
import 'package:sheba_pathway/screens/map_screen.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:sheba_pathway/screens/you_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: FloatingNavbar(
                currentIndex: _currentpage,
                iconSize: 15,
                padding: EdgeInsets.all(2),
                
                onTap: (value) {
                  setState(() {
                    _currentpage = value;
                  });
                },
                items: [
                  FloatingNavbarItem(
                    icon: FontAwesomeIcons.home,
                    title: "Home",
                  ),
                  FloatingNavbarItem(
                    icon: Icons.hotel_outlined,
                    title: "Hotels",
                  ),
                  FloatingNavbarItem(
                      icon: FontAwesomeIcons.mapLocation, title: "Map"),
                  FloatingNavbarItem(
                      icon: Icons.favorite_border, title: "Saved"),
                  FloatingNavbarItem(
                      icon: Icons.person_2_outlined, title: 'You')
                ]),
          ),
          body: _getBody(_currentpage)),
    );
  }

  Widget _getBody(int page) {
    switch (page) {
      case 0:
        return const HomeScreen();
      case 1:
        return const HotelScreen();
      case 2:
        return const MapScreen();
      case 3:
        return const HomeScreen();
      case 4:
        return const YouScreen();
      default:
        return const HomeScreen();
    }
  }
}
