import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/login/GetLoginData.dart';
import '../../service/SharedPref.dart';
import '../onboarding/login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String bloodType = "A+";
  ImageProvider? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = FileImage(File(pickedFile.path));
      });
    }
  }

  String? userName;
  String? userLocation;
  String? userNumber;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserDatas();
  }

  Future<void> _loadUserDatas() async {
    SharedPreferenceHelper sharedPrefs = SharedPreferenceHelper();
    GetLoginData? loginData = await sharedPrefs.getLoginData();

    if (loginData != null) {
      setState(() {
        userName = loginData.name;
        userEmail = loginData.email;
        userLocation = loginData.place;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6E5E6), // Background color
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Text(
              'My Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Color(0xFFC5141A),
              ),
            ),
            SizedBox(height: 30),
            // Profile Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage:
                  _image ?? AssetImage('assets/default_profile.jpg'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Icon(Icons.edit, color: Colors.black87, size: 18,),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Personal Information Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Personal info',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  _buildProfileDetailRow(
                    icon: Icons.person_outline_rounded,
                    title: 'Your name',
                    value: userName ?? "username",
                  ),
                  _buildProfileDetailRow(
                    icon: Icons.bloodtype_outlined,
                    title: 'Blood Type',
                    value: bloodType,
                  ),
                  _buildProfileDetailRow(
                    icon: Icons.location_on_outlined,
                    title: 'Place',
                    value: userLocation ?? "location",
                  ),


                  _buildProfileDetailRow(
                    icon: Icons.phone_outlined,
                    title: 'Phone number',
                    value: userNumber ?? "9745345633",
                  ),
                  _buildProfileDetailRow(
                    icon: Icons.email_outlined,
                    title: 'Email address',
                    value: userEmail ?? "Email",
                  ),
                  SizedBox(height: 40,),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const LoginPage();
                          }),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12), // Padding for better touch target
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Rounded corners
                        ),
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          fontFamily: 'Poppins', // Custom font family
                          fontSize: 16, // Slightly larger font for better readability
                          fontWeight: FontWeight.w600, // Bold text for emphasis
                        ),
                      ),
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

  Widget _buildProfileDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black54, size: 30,),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
