import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../service/apiService.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _value = 1;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  ApiService apiService = ApiService();
  bool passwordVisible = true;

  void toggle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      right: true,
      left: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xFFF5F5F5),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      shadows: [
                        Shadow(
                          color: Colors.grey.shade400,
                          offset: Offset(-1, -2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Name",
                        labelText: "Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFFC5141A).withOpacity(0.1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Color(0xFFC5141A).withOpacity(0.05),
                        filled: true,
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Must fill name";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Phone",
                        labelText: "Phone",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFFC5141A).withOpacity(0.1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Color(0xFFC5141A).withOpacity(0.05),
                        filled: true,
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Must fill phone number";
                        } else if (v.length < 10) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: TextFormField(
                      controller: placeController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        hintText: "Place",
                        labelText: "Place",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFFC5141A).withOpacity(0.1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Color(0xFFC5141A).withOpacity(0.05),
                        filled: true,
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Must fill place";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: TextFormField(
                      controller: pincodeController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        hintText: "Pincode",
                        labelText: "Pincode",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFFC5141A).withOpacity(0.1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Color(0xFFC5141A).withOpacity(0.05),
                        filled: true,
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Must fill pincode";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email",
                        labelText: "Email",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFFC5141A).withOpacity(0.1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Color(0xFFC5141A).withOpacity(0.05),
                        filled: true,
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Must fill email";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Password",
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: toggle,
                          icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFFC5141A).withOpacity(0.1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Color(0xFFC5141A).withOpacity(0.05),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if(formkey.currentState!.validate()){
                        apiService.registration(
                            nameController.text,
                            int.parse(phoneController.text),
                            placeController.text,
                            int.parse(pincodeController.text),
                            emailController.text,
                            passwordController.text
                        );
                      }
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
                      padding: EdgeInsets.symmetric(horizontal: 128.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
