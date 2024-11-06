import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dbhelper.dart';
import '../user.dart';
import 'HomePage.dart';

class DonorListPage extends StatefulWidget {
  @override
  _DonorListPageState createState() => _DonorListPageState();
}

class _DonorListPageState extends State<DonorListPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper(); // Make helper private
  late Future<List<User>?> _donatorListFuture; // Make the future private
  String _searchQuery = ""; // Store search query

  @override
  void initState() {
    super.initState();
    _loadDonors();
  }

  void _loadDonors() {
    _donatorListFuture = _databaseHelper.getAllUsers().then((data) {
      return data?.where((user) {
        return user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.location.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  int _selectedIndex = 1; // Initialize selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBB2727),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Donor List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _searchContainer(),
            const SizedBox(height: 16),
            Expanded(child: _donorList()),
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex, // Manage the selected index
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return HomeScreen();
            }));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return DonorListPage();
            }));
          }
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
            icon: Icon(Icons.notifications_none),
            title: Text("Alert"),
            selectedColor: Color(0xFFC5141A),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Color(0xFFC5141A),
          ),
        ],
      ),
    );
  }

  Widget _searchContainer() {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
            _loadDonors(); // Reload list based on search query
          });
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search for a donor...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _donorList() {
    return FutureBuilder<List<User>?>(
      future: _donatorListFuture,
      builder: (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Something went wrong: ${snapshot.error}",
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No donor data found",
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(8),
                      shadowColor: Colors.grey.shade300,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red[100],
                          child: Text(user.bloodGroup ?? '?'),
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
                                  ),
                                ),
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
                },
              );
            }
          default:
            return const Center(
              child: Text(
                "Unknown state",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            );
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