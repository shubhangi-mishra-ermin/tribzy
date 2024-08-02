import 'package:flutter/material.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/textfield.dart';
import 'package:tribzyco/authenctication/widget/dropdown.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/screens/event/eventdescription.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _aptNoController = TextEditingController();
  final TextEditingController _hostedByController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedPlace = 'Apartment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Community events',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Text(
                'Event Name',
                style: AppTextStyle.mediumgrey14,
              ),
              SizedBox(height: 8),
              TextFeildStyle(
                hintText: 'Event Name',
                fillColor: Color(0xffFAFBFB),
                textAlignVertical: TextAlignVertical.center,
                controller: _eventNameController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {},
              ),
              // SizedBox(height: 16),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: AppTextStyle.mediumgrey14,
                        ),
                        SizedBox(height: 8),
                        TextFeildStyle(
                          hintText: '27/05/2002',
                          fillColor: Color(0xffFAFBFB),
                          textAlignVertical: TextAlignVertical.center,
                          controller: _dateController,
                          keyboardType: TextInputType.datetime,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time',
                          style: AppTextStyle.mediumgrey14,
                        ),
                        SizedBox(height: 8),
                        TextFeildStyle(
                          hintText: '09:20',
                          fillColor: Color(0xffFAFBFB),
                          textAlignVertical: TextAlignVertical.center,
                          controller: _timeController,
                          keyboardType: TextInputType.datetime,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Place',
                style: AppTextStyle.mediumgrey14,
              ),
              SizedBox(height: 8),
              CustomDropdownField(
                label: '',
                withoutLabel: false,
                controller: _apartmentController,
                items: ['Apartment', 'Club house', 'Pool', 'Others'],
              ),
              SizedBox(height: 16),
              Text(
                'Apt No.',
                style: AppTextStyle.mediumgrey14,
              ),
              SizedBox(height: 8),
              TextFeildStyle(
                hintText: '123',
                fillColor: Color(0xffFAFBFB),
                textAlignVertical: TextAlignVertical.center,
                controller: _aptNoController,
                keyboardType: TextInputType.name,
                onChanged: (value) {},
              ),
              SizedBox(height: 16),
              Text(
                'Hosted By',
                style: AppTextStyle.mediumgrey14,
              ),
              SizedBox(height: 8),
              TextFeildStyle(
                hintText: 'sammy',
                fillColor: Color(0xffFAFBFB),
                textAlignVertical: TextAlignVertical.center,
                controller: _hostedByController,
                keyboardType: TextInputType.name,
                onChanged: (value) {},
              ),
              SizedBox(height: 16),
              Text(
                'Description',
                style: AppTextStyle.mediumgrey14,
              ),
              SizedBox(height: 8),
              TextFeildStyle(
                hintText: 'Event Name',
                fillColor: Color(0xffFAFBFB),
                textAlignVertical: TextAlignVertical.center,
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                maxLines: 5,
                onChanged: (value) {},
              ),
              SizedBox(height: 16),
              CustomButton(
                  text: 'Post Event',
                  onPressed: () {
                  })
            ],
          ),
        ),
      ),
    );
  }
}
