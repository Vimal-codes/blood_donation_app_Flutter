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

  void showSnackbar(String message, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            color: const Color(0xFFF5F5F5),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          offset: Offset(-1, -2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: nameController,
                    icon: Icons.person,
                    label: "Name",
                    hint: "Name",
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Must fill name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: phoneController,
                    icon: Icons.phone,
                    label: "Phone",
                    hint: "Phone",
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Must fill phone number";
                      } else if (v.length < 10) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: placeController,
                    icon: Icons.location_on,
                    label: "Place",
                    hint: "Place",
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Must fill place";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: pincodeController,
                    icon: Icons.location_city,
                    label: "Pincode",
                    hint: "Pincode",
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Must fill pincode";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: emailController,
                    icon: Icons.email,
                    label: "Email",
                    hint: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Must fill email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: passwordController,
                    icon: Icons.lock,
                    label: "Password",
                    hint: "Password",
                    obscureText: passwordVisible,
                    suffixIcon: IconButton(
                      onPressed: toggle,
                      icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Must fill password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        try{
                          bool isRegistered = await apiService.registration(
                            nameController.text.trim(),
                            int.tryParse(phoneController.text.trim()) ?? 0,
                            placeController.text.trim(),
                            int.tryParse(pincodeController.text.trim()) ?? 0,
                            emailController.text.trim(),
                            passwordController.text,
                          );
                          if (isRegistered) {
                            // Show success SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text('User registered successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // Navigate to Login page after a delay
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            });
                          } else {
                            // Show error SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text('Registration failed! Please try again.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }catch (e){
                          // Show exception SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text('An unexpected error occurred: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC5141A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 128.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
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

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          labelText: label,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: const Color(0xFFC5141A).withOpacity(0.1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          fillColor: const Color(0xFFC5141A).withOpacity(0.05),
          filled: true,
        ),
        validator: validator,
      ),
    );
  }
}
