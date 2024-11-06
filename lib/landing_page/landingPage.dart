import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../home_screens/HomePage.dart';
import '../onboarding/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingScreen(),
    );
  }
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<LandingPage> _pages = [
    const LandingPage(
      title: "Donate Blood, Save Lives",
      description: "A cheerful blood bag character with a smiling face connected to a heart. This visual symbolizes the life-saving impact of blood donations in a friendly and welcoming manner.",
      imagePath: "assets/images/lpage1.png",
    ),
    const LandingPage(
      title: "Track and Add Donors",
      description: "Effortlessly manage and add new blood donors. Reach out to donors directly via call or WhatsApp, making communication simple and streamlined.",
      imagePath: "assets/images/lpage2.png",
    ),
    const LandingPage(
      title: "Join the Mobile Blood Drive",
      description: "An NHS-branded blood donation van with the message Please give blood. This image encourages people to participate in mobile blood drives, making donation more accessible and convenient.",
      imagePath: "assets/images/lpage3.png",
      isLastPage: true,
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    _pageController.jumpToPage(_pages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFEFF),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Column(
                children: [
                  Expanded(
                    child: LandingPage(
                      title: page.title,
                      description: page.description,
                      imagePath: page.imagePath,
                      isLastPage: page.isLastPage,
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 50,
            left: 16,
            right: 16,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Color(0xFFC5141A),
                    dotColor: Colors.grey,
                    expansionFactor: 4,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage < _pages.length - 1)
                      TextButton(
                        onPressed: _skip,
                        child: const Text("Skip", style: TextStyle(fontFamily: 'Poppins', color: Color(0xFFC5141A), fontWeight: FontWeight.w600, fontSize: 15)),
                      ),
                    if (_currentPage < _pages.length - 1)
                      TextButton(
                        onPressed: _nextPage,
                        child: const Text("Next", style: TextStyle(fontFamily: 'Poppins', color: Color(0xFFC5141A), fontWeight: FontWeight.w600, fontSize: 15)),
                      ),
                    if (_currentPage == _pages.length - 1)
                      Spacer(), // Adds space to push the "Start" button to the right side
                    if (_currentPage == _pages.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const LoginPage();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC5141A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                          shape: const StadiumBorder(),
                          elevation: 5,
                        ),
                        child: const Text("Start", style: TextStyle(fontFamily: 'Poppins', fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLastPage;

  const LandingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 200),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }
}
