import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tribzyco/screens/community/community.dart';
import 'package:tribzyco/screens/event/event.dart';
import 'package:tribzyco/screens/home/homapage.dart';
import 'package:tribzyco/screens/homies/homiespage.dart';
import 'package:tribzyco/screens/profile/profile.dart';
import 'package:tribzyco/utilities/colors.dart';

class MainScreen2 extends StatefulWidget {
  final int initialIndex;

  const MainScreen2({super.key, this.initialIndex = 0});

  @override
  _MainScreen2State createState() => _MainScreen2State();
}

class _MainScreen2State extends State<MainScreen2> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    HomeScreen(),
    const CommunityPage(),
    const HomiesPage(),
    const EventPage(),
    const ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('icons/homeicon.svg'),
            activeIcon: SvgPicture.asset('icons/homeicon_filled.svg'),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('icons/comm_icon.svg'),
            activeIcon: SvgPicture.asset('icons/comm_icon_filled.svg'),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('icons/homies_icon.svg'),
            activeIcon: SvgPicture.asset('icons/homies_filled.svg'),
            label: "Homies",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('icons/eventicon.svg'),
            activeIcon: SvgPicture.asset('icons/event_filled.svg'),
            label: "Event",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('icons/profileicon.svg'),
            activeIcon: SvgPicture.asset('icons/profile_filled.svg'),
            label: "Profile",
          ),
        ],
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
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
