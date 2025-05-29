import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/bloc/hotel_bloc/all_hotels_widget/all_hotels_bloc.dart';
import 'package:sheba_pathway/repository/hotel_repository.dart';
import 'package:sheba_pathway/screens/blog_screen.dart';

import 'package:sheba_pathway/screens/home_screen.dart';
import 'package:sheba_pathway/screens/hotel_screen.dart';
import 'package:sheba_pathway/screens/map_screen.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:sheba_pathway/screens/you_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key,required this.currentPlaceName});
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
                    icon: Icons.article, title: "Blogs"),
                FloatingNavbarItem(
                    icon: Icons.person_2_outlined, title: 'You')
              ]),
        ),
        body: _getBody(_currentpage));
  }

  Widget _getBody(int page) {
    switch (page) {
      case 0:
        return  HomeScreen(currentPlaceName:widget.currentPlaceName ,);
      case 1:
        return  BlocProvider(
          create: (context) =>
              AllHotelsBloc(HotelRepository()),
          child: HotelScreen(),
        );

      case 2:
        return const MapScreen();
      case 3:
        return  BlogScreen();
      case 4:
        return const YouScreen();
      default:
        return  HomeScreen(currentPlaceName:  widget.currentPlaceName);
    }
  }
}
