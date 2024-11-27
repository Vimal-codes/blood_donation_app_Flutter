import 'package:blood_donation_app_flutter/service/SharedPref.dart';
import 'package:blood_donation_app_flutter/service/apiService.dart';
import 'package:flutter/material.dart';
import '../../model/login/GetLoginData.dart';
import '../home_screens/HomePage.dart';
import 'Signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ApiService apiService = ApiService();
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      right: true,
      left: true,
      child: Scaffold(
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Container(
              color: Color(0xFFF5F5F5),
              child: Column(
                children: [
                  SizedBox(height: 90),
                  Text(
                    "Welcome Back",
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
                  Text(
                    "Enter your credential for login",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 2),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Username",
                        labelText: "Username",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFFE5E5E5)), // Light border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Color(0xFFE5E5E5), // Light background color
                        filled: true,
                      ),
                      validator: (value){
                        return value!.isEmpty ? "Must Fill" : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        hintText: "Password",
                        labelText: "Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFFE5E5E5)), // Light border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Color(0xFFE5E5E5), // Light background color
                        filled: true,
                      ),
                      obscureText: true,
                      validator: (value){
                        return value!.isEmpty ? "Must Fill" : null;
                      },
                    ),
                  ),
                  SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: () async {
                      if(formkey.currentState!.validate()){
                        GetLoginData? res=  await apiService.login(emailController.text, passwordController.text);
                        if(res!=null){
                          await  sharedPreferenceHelper.saveLoginData(res).then((value){
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return const HomeScreen();
                              }),
                            );
                          }) ;
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC5141A),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 118.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      "Login Now",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                      //   return otpVerify();
                      // }));
                    },
                    child: Text(
                      "Forget password?",
                      style: TextStyle(
                        color: Color(0xFFC5141A),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(height: 160),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return SignUp();
                          }));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC5141A),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
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

