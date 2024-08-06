import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String _currentUserCredential;

  @override
  void initState() {
    super.initState();
    _currentUserCredential = '';
    _getCurrentUserCredential();
  }

  Future<void> _getCurrentUserCredential() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUserCredential = user != null ? user.uid : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'images/appLogo.svg',
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('icons/login.svg'),
              SizedBox(width: 8), // Adjust spacing
              _currentUserCredential.isEmpty
                  ? GestureDetector(
                      onTap: () {
                        nextPage(context, LoginPage());
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await _auth.signOut();
                        setState(() {
                          _currentUserCredential = '';
                        });
                        nextPage(context, LoginPage());
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //         builder: (context) => LoginPage()),
                        //     (Route<dynamic> route) => false);
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ],
      ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 12.0),
      //     child: SvgPicture.asset('icons/menu.svg'),
      //   ),
      // ],
    );
  }
}
