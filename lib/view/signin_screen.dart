import 'package:flutter/material.dart';
import 'package:carmark/view/forgot_pass.dart';
import 'package:carmark/view/signup_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _ispasswordvisible = true;
  var useredit = TextEditingController();
  var passedit = TextEditingController();
  final onekey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              key: onekey,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome Back !",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please sign in ",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 100.h,
                ),
                Card(
                  elevation: 10,
                  child: TextFormField(
                    controller: useredit,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      label: Text("Username"),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.account_circle_outlined),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  elevation: 10,
                  child: TextFormField(
                    controller: passedit,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                      suffixIcon: _ispasswordvisible
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _ispasswordvisible = !_ispasswordvisible;
                                });
                              },
                              icon: Icon(Icons.visibility))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  _ispasswordvisible = !_ispasswordvisible;
                                });
                              },
                              icon: Icon(Icons.visibility_off)),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _ispasswordvisible,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ));
                        },
                        child: Text("Forgot password?")),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text("Sign In")),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0).r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SignInButton(Buttons.GoogleDark, onPressed: () {

                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Dont have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ));
                          },
                          child: Text("Sign up")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
