import 'package:blood_donation_app_flutter/util/user.dart';
import 'package:flutter/material.dart';

import '../../dbhelper.dart';
class Registration extends StatefulWidget {
  final VoidCallback? onRegistered; // Add this callback parameter

  const Registration({super.key, this.onRegistered});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController lastDonatedController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // Dropdown and radio button values
  String selectedSex = '';
  String selectedBloodGroup = 'A+';
  List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E6E7),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 65),
              Center(child: const Text("Registration",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27,fontFamily: 'Poppins', color: Color(0xFFC5141A)))),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when focused
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when not focused
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: weightController,
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when focused
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when not focused
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid weight';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: heightController,
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when focused
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when not focused
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid height';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when focused
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when not focused
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when focused
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when not focused
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: lastDonatedController,
                  decoration: InputDecoration(
                    labelText: 'Last Donation Date (YYYY-MM-DD)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when focused
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Curved edges when not focused
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the last donation date';
                    }
                    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                      return 'Please enter a valid date in YYYY-MM-DD format';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),

              Row(
                children: [
                  const Text("Sex: "),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: selectedSex,
                        onChanged: (String? value) {
                          setState(() {
                            selectedSex = value!;
                          });
                        },
                      ),
                      const Text('Male'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Female',
                        groupValue: selectedSex,
                        onChanged: (String? value) {
                          setState(() {
                            selectedSex = value!;
                          });
                        },
                      ),
                      const Text('Female',style: TextStyle(fontFamily: 'Poppins')),
                    ],
                  ),
                ],
              ),
              if (selectedSex.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Please select a sex',
                    style: TextStyle(color: Colors.red, fontFamily: 'Poppins'),
                  ),
                ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedBloodGroup,
                items: bloodGroups.map((String bloodGroup) {
                  return DropdownMenuItem<String>(
                    value: bloodGroup,
                    child: Text(bloodGroup),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBloodGroup = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0), // Curved edges
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0), // Curved edges when focused
                    borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0), // Curved edges when not focused
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(color: Color(0xFFC5141A), width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && selectedSex.isNotEmpty) {
                      User newUser = User(
                        name: nameController.text,
                        sex: selectedSex,
                        weight: double.tryParse(weightController.text) ?? 0.0,
                        height: double.tryParse(heightController.text) ?? 0.0,
                        bloodGroup: selectedBloodGroup,
                        lastDonated: lastDonatedController.text,
                        phone: phoneController.text,
                        location: locationController.text,
                      );

                      await _databaseHelper.insertUser(newUser);

                      // Call the callback to refresh the list
                      if (widget.onRegistered != null) {
                        widget.onRegistered!();
                      }

                      Navigator.of(context).pop(); // Close after saving
                    } else if (selectedSex.isEmpty) {
                      setState(() {}); // Trigger rebuild to show error message for sex
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC5141A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    shape: const StadiumBorder(),
                    elevation: 5,
                  ),
                  child: const Text("Register",style: TextStyle(fontSize: 18,fontFamily: 'Poppins')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
