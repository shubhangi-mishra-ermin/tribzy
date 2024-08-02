// import 'package:flutter/material.dart';
// import 'package:tribzyco/authenctication/widget/chipgroup.dart';
// import 'package:tribzyco/authenctication/widget/dropdown.dart';
// import 'package:tribzyco/authenctication/widget/radiobutton.dart';
// import 'package:tribzyco/authenctication/widget/sliderstep.dart';
// import 'package:tribzyco/utilities/textstyles.dart';

// class Step1Content extends StatelessWidget {
//   final TextEditingController countryController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Habits and Preferences',
//               style: AppTextStyle.semibold18,
//             ),
//             SizedBox(height: 20),
//             CustomDropdownField(
//               label: 'Which country are you from?',
//               controller: countryController,
//               items: ['Select Country', 'Country 1', 'Country 2'],
//             ),
//             SizedBox(height: 20),
//             CustomDropdownField(
//               label: 'Which state are you from?',
//               controller: stateController,
//               items: ['Select State', 'State 1', 'State 2'],
//             ),
//             SizedBox(height: 20),
//             CustomDropdownField(
//               label: 'What is your Age',
//               controller: ageController,
//               items: ['18 - 24', '24 - 30', '30+'],
//             ),
//             SizedBox(height: 20),
//             CustomRadioGroup(
//               label: 'What is your sleep pattern like?',
//               options: ['Morning person', 'Night owl', 'No fixed timings'],
//             ),
//             SizedBox(height: 20),
//             CustomRadioGroup(
//               label: 'How often do you smoke or drink?',
//               options: ['Sometimes', 'More often', 'Never'],
//             ),
//             SizedBox(height: 20),
//             CustomRadioGroup(
//               label: 'Are you pet-friendly?',
//               options: ['Yes', 'No'],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Step2Content extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Characteristics and Interests',
//               style: AppTextStyle.semibold18,
//             ),
//             SizedBox(height: 20),
//             CustomRadioGroup(
//               label: '7. What is your gender?',
//               options: ['Male', 'Female', 'Others'],
//             ),
//             SizedBox(height: 20),
//             CustomRadioGroup(
//               label: '8. How would you describe your personality?',
//               options: ['Introvert', 'Extrovert', 'Ambivert'],
//             ),
//             SizedBox(height: 20),
//             CustomChipGroup(
//               label: '9. What are your hobbies and interests?',
//               options: [
//                 'Movies',
//                 'Badminton',
//                 'Cricket',
//                 'Singing',
//                 'Traveling',
//                 'Dancing',
//                 'Gaming',
//                 'Cooking',
//                 'Reading'
//               ],
//             ),
//             SizedBox(height: 20),
//             CustomRadioGroup(
//               label: '10. What is your diet preference?',
//               options: ['Vegetarian', 'Non-vegetarian', 'Vegan'],
//             ),
//             SizedBox(height: 20),
//             CustomSliderGroup(
//               label: '11. Rate your cooking skills on a scale of 1 to 10.',
//               initialValue: 4,
//               min: 0,
//               max: 10,
//             ),
//             SizedBox(height: 20),
//             CustomRadioGroup(
//               label: '12. How often do you travel?',
//               options: ['Sometimes', 'More often', 'Never'],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Step3Content extends StatelessWidget {
//   final TextEditingController majorController = TextEditingController();
//   final TextEditingController degreeTypeController = TextEditingController();
//   final TextEditingController careerPathController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Academic and Background',
//               style: AppTextStyle.semibold18,
//             ),
//             SizedBox(height: 20),
//             CustomDropdownField(
//               label: '13. What is your major?',
//               controller: majorController,
//               items: ['Select Major', 'CS', 'ECE', 'ISOM', 'Chemical', 'Others'],
//             ),
//             SizedBox(height: 20),
//             CustomDropdownField(
//               label: '14. What is your degree type?',
//               controller: degreeTypeController,
//               items: ['Select degree type', 'UG', 'Masters', 'PhD', 'Others'],
//             ),
//             SizedBox(height: 20),
//             CustomDropdownField(
//               label: '15. What is your career path?',
//               controller: careerPathController,
//               items: ['Select career domain', 'Computer Science: UI/UX, Frontend, Backend, Mobile Development', 'Electronics and Communication: VLSI, Circuit Design, Networking', 'Other Domains: Add relevant options as needed'],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
