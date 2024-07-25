import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tribzyco/screens/community/community.dart';
import 'package:tribzyco/screens/event/event.dart';
import 'package:tribzyco/screens/home/homapage.dart';
import 'package:tribzyco/screens/profile/profile.dart';
import 'package:tribzyco/utilities/colors.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.initialIndex);
  }

  List<Widget> _buildScreens() => [
        const HomeScreen(),
        const CommunityPage(),
        const EventPage(),
        const ProfilePage()
      ];

  List<PersistentTabConfig> _navBarsItems() => [
        PersistentTabConfig(
          screen: const HomeScreen(),
          item: ItemConfig(
            activeColorSecondary: primaryColor,
            textStyle: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor),
            icon: SvgPicture.asset('icons/homeicon_filled.svg'),
            inactiveIcon: SvgPicture.asset('icons/homeicon.svg'),
            title: "Home",
          ),
        ),
        PersistentTabConfig(
          screen: const CommunityPage(),
          item: ItemConfig(
            textStyle: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor),
            icon: SvgPicture.asset('icons/comm_icon_filled.svg'),
            inactiveIcon: SvgPicture.asset('icons/comm_icon.svg'),
            title: "Community",
          ),
        ),
        PersistentTabConfig(
          screen: const EventPage(),
          item: ItemConfig(
            textStyle: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor),
            icon: SvgPicture.asset('icons/event_filled.svg'),
            inactiveIcon: SvgPicture.asset('icons/eventicon.svg'),
            title: "Event",
          ),
        ),
        PersistentTabConfig(
          screen: const ProfilePage(),
          item: ItemConfig(
            textStyle: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor),
            icon: SvgPicture.asset('icons/profile_filled.svg'),
            inactiveIcon: SvgPicture.asset('icons/profileicon.svg'),
            title: "Profile",
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) => PersistentTabView(
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
        ),
        tabs: _navBarsItems(),
        controller: _controller,
        navBarHeight: 60.0,
      );
}
