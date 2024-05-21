import 'package:flutter/material.dart';
import 'package:carmark/view/signup_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/email-controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotkey = GlobalKey<FormState>();
  var emailfController = TextEditingController();
  var emailpattern = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$');
  final EmailController _emailController = Get.put(EmailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: forgotkey,
          child: Column(
            children: [
              const Row(
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
                child: SizedBox(
                  height: 80.h,
                  width: 200.w,
                  child: Text("Enter the email associated with your account."
                      " A reset link will be "
                      "sent to this email."),
                ),
              ),
              SizedBox(
                height: 50.h,
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
                  },
                  controller: emailfController,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0).r,
                child: SizedBox(
                  width: 270.w,
                  height: 40.h,
                  child: ElevatedButton(
                      onPressed: () {
                        if (forgotkey.currentState!.validate()) {
                          String forgotEmail = emailfController.text.trim();

                          if (forgotEmail.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Please enter all details",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else {
                            _emailController.forgotPassword(forgotEmail);
                          }
                        }
                      },
                      child: const Text("Submit")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Signup(),
                              ));
                        },
                        child: const Text("Sign up")),
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
