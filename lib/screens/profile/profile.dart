import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 26.0, horizontal: 16),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 40), // Space for status bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: AppTextStyle.semibold18
                            .copyWith(color: Colors.white),
                      ),
                      SvgPicture.asset('icons/bell.svg'),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('images/Group 427323160.png'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sammy Taylor',
                            style: AppTextStyle.bold24,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '+91 7004986659',
                            style: AppTextStyle.medium14
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'sammytaylor@gmail.com',
                            style: AppTextStyle.medium14
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),

                  SizedBox(height: 20),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.purple),
              title: Text('Personal'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.purple),
              title: Text('Privacy and Security'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard, color: Colors.purple),
              title: Text('Offers and Rewards'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.purple),
              title: Text('Help'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.purple),
              title: Text('Logout'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
