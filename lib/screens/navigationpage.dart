import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tribzyco/screens/community/community.dart';
import 'package:tribzyco/screens/event/event.dart';
import 'package:tribzyco/screens/home/homapage.dart';
import 'package:tribzyco/screens/homies/homiespage.dart';
import 'package:tribzyco/screens/profile/profile.dart';
import 'package:tribzyco/utilities/colors.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    HomeScreen(),
    const CommunityPage(),
    HomiesPage(),
    const EventPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildNavItem(
      {required String activeIconPath,
      required String inactiveIconPath,
      required String title}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(inactiveIconPath),
      activeIcon: SvgPicture.asset(activeIconPath),
      label: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildNavItem(
            activeIconPath: 'icons/homeicon_filled.svg',
            inactiveIconPath: 'icons/homeicon.svg',
            title: 'Home',
          ),
          _buildNavItem(
            activeIconPath: 'icons/comm_icon_filled.svg',
            inactiveIconPath: 'icons/comm_icon.svg',
            title: 'Community',
          ),
          _buildNavItem(
            activeIconPath: 'icons/homies_filled.svg',
            inactiveIconPath: 'icons/homies_icon.svg',
            title: 'Homies',
          ),
          /* BottomNavigationBarItem(
            icon: SvgPicture.asset('icons/homies_icon.svg'),
            activeIcon: SvgPicture.asset('icons/homies_filled.svg'),
            label: "Homies",
          ),*/
          _buildNavItem(
            activeIconPath: 'icons/event_filled.svg',
            inactiveIconPath: 'icons/eventicon.svg',
            title: 'Event',
          ),
          _buildNavItem(
            activeIconPath: 'icons/profile_filled.svg',
            inactiveIconPath: 'icons/profileicon.svg',
            title: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
