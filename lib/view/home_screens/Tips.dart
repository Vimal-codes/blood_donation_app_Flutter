import 'package:flutter/material.dart';

class Tips extends StatefulWidget {
  const Tips({super.key});

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFF),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Blood Donation Guidelines',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFBB2727),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.help_outline_sharp, size: 24),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: ListView(
          children: [
            SectionTitle('Pre-Donation Tips'),
            BulletPointList([
              'Hydrate Well: Drink plenty of water or juice before donating. Avoid caffeinated drinks as they can dehydrate you.',
              'Eat Iron-Rich Foods: Consume foods rich in iron like spinach, beans, and red meat a few days before donating.',
              'Sleep Well: Get a full night’s rest (7-8 hours) to ensure you’re ready.',
              'Avoid Alcohol: Refrain from drinking alcohol for at least 24 hours before donating.',
              'Wear Comfortable Clothing: Wear sleeves that can easily roll up above the elbow for easier access.'
            ]),

            SectionTitle('Blood Type Matching'),
            BloodTypeImage(),
            const SizedBox(height: 15),

            SectionTitle('Eligibility Requirements'),
            BulletPointList([
              'Age and Weight: Donors should generally be between 18-65 years old and weigh at least 50 kg (110 lbs).',
              'Health Condition: Donors should be in good health, free from infections or fevers.',
              'Donation Frequency: Wait at least 8 weeks between whole blood donations; check specific waiting periods for platelet or plasma donations.',
              'Travel and Medical History: Certain areas or medical conditions may require a waiting period before donating.',
              'Medications: Some medications may make you temporarily ineligible. Check with the blood donation center if unsure.'
            ]),

            SectionTitle('During Donation Tips'),
            BulletPointList([
              'Relax and Breathe: Take deep breaths to reduce any anxiety.',
              'Follow Instructions: Listen to the medical staff and inform them if you feel uncomfortable.',
              'Squeeze the Stress Ball: Squeezing a stress ball periodically can help with blood flow.'
            ]),

            SectionTitle('Post-Donation Tips'),
            BulletPointList([
              'Rest: Sit and relax for at least 10-15 minutes after donating.',
              'Hydrate and Eat: Drink fluids and have a small snack to replenish energy.',
              'Avoid Heavy Lifting and Activities: Refrain from intense activities for the next 24 hours.',
              'Stay in Contact: If you feel unwell, contact the donation center or a healthcare provider.',
              'Monitor the Needle Site: Watch for any unusual swelling or discomfort and notify a healthcare provider if necessary.'
            ]),
          ],
        ),
      ),
    );
  }

  Widget SectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFFC5141A),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget BulletPointList(List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => BulletPoint(item)).toList(),
      ),
    );
  }

  Widget BulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 10.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget BloodTypeImage() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Image.asset(
        'assets/images/table.jpg', // Make sure to replace with your actual image path
        fit: BoxFit.contain,
      ),
    );
  }
}
