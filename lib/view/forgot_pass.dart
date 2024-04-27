import 'package:flutter/material.dart';
import 'package:carmark/view/signup_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var emailedit = TextEditingController();
  final onekey = GlobalKey<FormState>();
  var emailpattern = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: onekey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Reset Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 25,
                        color: Colors.black87),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0).r,
                child: Card(
                  elevation: 10,
                  child: Text("Enter the email associated with your account."
                      " A reset link will be "
                      "sent to this email."),
                ),
              ),
              SizedBox(
                height: 100.h,
                width: 5.w,
              ),
              Card(
                elevation: 10,
                child: TextFormField(
                  validator: (value) {
                    {
                      if (value!.isEmpty) {
                        return ("Please enter email");
                      } else if (!emailpattern.hasMatch(value)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    }
                    ;
                  },
                  controller: emailedit,
                  decoration: InputDecoration(
                    label: Text("Email"),
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (onekey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Success")));
                          }
                        },
                        child: Text("Continue")),
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
                          Navigator.pushReplacement(
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
      ),
    );
  }
}
