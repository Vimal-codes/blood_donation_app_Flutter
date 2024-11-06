import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  int _value = 1;
  final _formKey = GlobalKey<FormState>();
  bool passwordvisible = true;

  void toggle() {
    setState(() {
      passwordvisible = !passwordvisible;
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
          body: Container(
            color: Color(0xFFF5F5F5),
            child: Form(
              key: _formKey,
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
                      controller: username,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Username",
                        labelText: "Username",
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
                      controller: email,
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
                    padding: const EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Text(
                          "Gender:",
                          style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                        ),
                        SizedBox(width: 10),
                        Radio(
                          value: 1,
                          groupValue: _value,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _value = value;
                              });
                            }
                          },
                        ),
                        Text("Male", style: TextStyle(fontFamily: 'Poppins')),
                        Radio(
                          value: 2,
                          groupValue: _value,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _value = value;
                              });
                            }
                          },
                        ),
                        Text("Female", style: TextStyle(fontFamily: 'Poppins')),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: TextFormField(
                      controller: password,
                      obscureText: passwordvisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Password",
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: toggle,
                          icon: Icon(passwordvisible ? Icons.visibility_off : Icons.visibility),
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
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: TextFormField(
                      controller: confirmPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Confirm Password",
                        labelText: "Confirm Password",
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle successful form submission
                      }
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
        ));
  }
}
