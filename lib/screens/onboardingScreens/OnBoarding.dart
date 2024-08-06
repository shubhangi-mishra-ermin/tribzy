import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<OnboardingData> _pages = [
    OnboardingData(
      image: 'images/onboarding1.svg',
      title: 'Create Your Profile',
      description:
          'Start by setting up your profile to find your ideal roommate and make the most out of Tribzy',
    ),
    OnboardingData(
      image: 'images/onboarding1.svg',
      title: 'Explore Communities',
      description:
          'Find and join communities that match your interests and lifestyle for a more connected experience.',
    ),
    OnboardingData(
      image: 'images/onboarding1.svg',
      title: 'Network at Events',
      description:
          'Connect with attendees at events and form tribes to collaborate and grow together.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: SvgPicture.asset(_pages[index].image),
                      ),
                      SizedBox(height: 12),
                      Text(
                        _pages[index].title,
                        style: AppTextStyle.bold24.copyWith(color: blackColor),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          _pages[index].description,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.semibold16
                              .copyWith(color: Color(0xff8B8F94)),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => buildDot(index, context),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _currentPage == 0
                        ? null
                        : () {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                    child: Text(
                      'Previous',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff8B8F94),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _currentPage == _pages.length - 1
                        ? () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()),
                            );
                          }
                        : () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Finish' : 'Next',
                      style: TextStyle(fontSize: 18, color: Color(0xff8B8F94)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 20 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: _currentPage == index ? primaryColor : Colors.grey,
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
