import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tribzyco/Widget/textfield.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/progressHud.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';
import 'package:tribzyco/utilities/validatorts.dart';

class ManageProfile extends StatefulWidget {
  const ManageProfile({super.key});

  @override
  State<ManageProfile> createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  File? _image;
  String profilepic = '';

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  final _auth = FirebaseAuth.instance;
  User? _loggedInUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _loggedInUser = user;
      });
      // Fetch user data if needed
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String fileName = 'profile_${_loggedInUser!.uid}.jpg';
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('Profile images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      String userId = _loggedInUser!.uid;

      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'profile_pic': downloadURL,
      });

      print('Profile image updated successfully');
      showSucessMessage(context, 'Profile image updated successfully');
    } catch (e) {
      print('Error uploading image: $e');
      showErrorMessage(context, 'Failed to upload image');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String userId = _loggedInUser!.uid;

      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'username': _fullNameController.text,
        'dob': _dobController.text,
      });

      print('User data updated successfully');
      showSucessMessage(context, 'User data updated successfully');
    } catch (e) {
      print('Error updating user data: $e');
      showErrorMessage(context, 'Failed to update user data');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      isLoading: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.arrow_back_ios),
                        Text(
                          'Personal Data',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: _image != null
                                      ? FileImage(_image!)
                                      : profilepic.isNotEmpty
                                          ? NetworkImage(profilepic)
                                              as ImageProvider<Object>?
                                          : AssetImage('images/Group 427323160.png'),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: _pickImage,
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: primaryColor,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Username',
                            style: AppTextStyle.mediumgrey14,
                          ),
                          SizedBox(height: 8),
                          TextFeildStyle(
                            hintText: 'Sammy',
                            fillColor: Color(0xffFAFBFB),
                            validation: FormValidators.validateFirstName,
                            textAlignVertical: TextAlignVertical.center,
                            controller: _fullNameController,
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Date of birth',
                            style: AppTextStyle.mediumgrey14,
                          ),
                          SizedBox(height: 8),
                          TextFeildStyle(
                            hintText: '09/09/2002',
                            fillColor: Color(0xffFAFBFB),
                            validation: FormValidators.validateFirstName,
                            textAlignVertical: TextAlignVertical.center,
                            controller: _dobController,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 10,
          width: MediaQuery.of(context).size.width * 0.9,
          child: CustomButton(
            text: 'Save',
            onPressed: () async {
              await _uploadImageToFirebase();
              await _updateUserData(); // Call to update user data
            },
          ),
        ),
      ),
    );
  }
}
