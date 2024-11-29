import 'package:blood_donation_app_flutter/service/dbhelper.dart';
import 'package:blood_donation_app_flutter/view/home_screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/login/GetLoginData.dart';
import '../../service/SharedPref.dart';
import '../../util/user.dart';
import '../onboarding/login.dart';
import 'Alertpage.dart';
import 'Tips.dart';
import 'donatorListFuture.dart';
import 'registration.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  List<Widget>pages = [
    HomeWidget(),
    DonorListPage(),
    Alertpage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFEFEFF),
        body: pages[_selectedIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex, // Manage the selected index
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Color(0xFFC5141A),
            ),

            SalomonBottomBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              selectedColor: Color(0xFFC5141A),
            ),

            SalomonBottomBarItem(
              icon: Icon(Icons.notifications_none), // Change icon as needed
              title: Text("Alert"), // Change title if needed
              selectedColor: Color(0xFFC5141A),
            ),

            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Color(0xFFC5141A),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  DatabaseHelper databaseHelper = DatabaseHelper();

  final List<String> imgList = [
    'assets/images/poster1.png',
    'assets/images/poster2.png',
    'assets/images/poster3.png',
  ];

  String? userName;
  String? userLocation;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferenceHelper sharedPrefs = SharedPreferenceHelper();
    GetLoginData? loginData = await sharedPrefs.getLoginData();

    if (loginData != null) {
      setState(() {
        userName = loginData.name; // Assuming 'name' is a field in GetLoginData
        userLocation = loginData.place; // Assuming 'place' is a field in GetLoginData
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) =>
        Container(
          margin: const EdgeInsets.all(1.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ))
        .toList();

    return SafeArea(
      top: true,
      left: true,
      right: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Color(0xFFFEFEFF),
        appBar: AppBar(
          backgroundColor: Color(0xFFC5141A),
          automaticallyImplyLeading: false,
          toolbarHeight: 68,
          title: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName != null ? "Hello $userName!" : "Hello!",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins', // Apply the Poppins font family
                  ),
                ),
                Text(
                  userLocation ?? "Location",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins', // Apply the Poppins font family
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: IconButton(
                icon: const Icon(Icons.logout, size: 25,color: Colors.white,), // Alert icon
                color: Color(0xFFC5141A), // Optional: Customize icon color
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const LoginPage();
                    }),
                  );
                },
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              top: 7,
              left: 0,
              right: 0,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 19 / 8,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
            ),
            const Positioned(
                top: 170,
                left: 10,
                child: Text("Our Services",
                  style: TextStyle(fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18),)
            ),
            Positioned(
              top: 203,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 200,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          return Registration(
                            onRegistered: () {
                              setState(() {}); // Trigger a rebuild to refresh the list
                            },
                          );
                        }));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFEFF4FF),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8), // Shadow color with opacity
                              spreadRadius: 2,                     // Spread radius
                              blurRadius: 5,                        // Blur radius
                              offset: Offset(2, 3),                 // Offset of the shadow
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 5,
                              left: 10,
                              right: 10,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Image.asset(
                                  "assets/icons/donate.png",
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 68,
                              left: 23,
                              right: 0,
                              child: Text(
                                "donate",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Add your action for the "requirement" container tap here
                        print("Requirement tapped");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFEFF4FF),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8), // Shadow color with opacity
                              spreadRadius: 2,                     // Spread radius
                              blurRadius: 5,                        // Blur radius
                              offset: Offset(2, 3),                 // Offset of the shadow
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 3,
                              left: 12,
                              right: 10,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Image.asset(
                                  "assets/icons/req.png",
                                  width: 66,
                                  height: 66,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 68,
                              left: 7,
                              right: 0,
                              child: Text(
                                "requirement",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tips()),
                        );
                      },

                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFEFF4FF),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8), // Shadow color with opacity
                              spreadRadius: 2,                     // Spread radius
                              blurRadius: 5,                        // Blur radius
                              offset: Offset(2, 3),                 // Offset of the shadow
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 7,
                              left: 8,
                              right: 10,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Image.asset(
                                  "assets/icons/tip.png",
                                  width: 57,
                                  height: 57,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 68,
                              left: 35,
                              right: 0,
                              child: Text(
                                "tips",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 323,
              left: 10,
              right: 0,
              child: Row(
                children: [
                  const Text(
                    "Donor List",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 195),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                        return DonorListPage();
                      }));
                    },
                    child: const Text("See All",
                      style: TextStyle(
                        color: Color(0xFFC5141A),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFFC5141A),
                      ),
                    ),

                  ),
                ],
              ),
            ),
            Positioned(
              top: 350,
              left: 10,
              right: 10,
              bottom: 0, // To ensure it fits within the screen
              child: _myList(),
            ),
          ],
        ),

      ),
    );
  }
  Widget _myList() {
    return FutureBuilder<List<User>?>(
      future: databaseHelper.getAllUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                  child: Text("Something went wrong: ${snapshot.error}",
                      style: const TextStyle(fontFamily: 'Poppins')));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text("No donator data found",
                      style: TextStyle(fontFamily: 'Poppins')));
            } else {
              // Display only the first three items
              final limitedList = snapshot.data!.take(3).toList();

              return Column(
                children: limitedList.map((user) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(8),
                      shadowColor: Colors.grey.shade300,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red[100],
                          child: Text(user.bloodGroup),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.location),
                        trailing: SizedBox(
                          width: 96,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _openWhatsApp(user.phone);
                                },
                                icon: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Image.asset(
                                      "assets/icons/whatsapp.png",
                                      width: 23,
                                      height: 23,
                                    )),
                              ),
                              IconButton(
                                onPressed: () {
                                  _callPhone(user.phone);
                                },
                                icon: const Icon(Icons.phone),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          default:
            return const Center(
                child: Text("Unknown state", style: TextStyle(fontFamily: 'Poppins')));
        }
      },
    );
  }
  void _callPhone(String number) async {
    final Uri callUri = Uri.parse("tel:$number");
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      print("Could not launch phone call to $number");
    }
  }

  void _openWhatsApp(String number) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$number");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      print("Could not open WhatsApp chat for $number");
    }
  }
}
