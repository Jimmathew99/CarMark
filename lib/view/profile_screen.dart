import 'package:carmark/controller/google-sign-in.dart';
import 'package:carmark/view/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/get-user-data-controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GoogleController googleSignInController = GoogleController();
  final GetUserDataController _getUserDataController =
      Get.put(GetUserDataController());

  late final User user;
  late List<QueryDocumentSnapshot<Object?>> userData = [];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _getUserData();
  }

  Future<void> _getUserData() async {
    userData = await _getUserDataController.getUserData(user.uid);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" My Profile"),
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 90.r,
            backgroundImage: NetworkImage(
              userData.isNotEmpty &&
                      userData[0]['userImg'] != null &&
                      userData[0]['userImg'].isNotEmpty
                  ? userData[0]['userImg']
                  : 'https://via.placeholder.com/150', // Placeholder URL for testing
            ),
          ),
          SizedBox(
            height: 70.h,
            width: 10.w,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: Card(
              elevation: 15,
              shape: OutlineInputBorder(),
              child: ListTile(
                title: Text(
                  "${userData.isNotEmpty ? userData[0]['username'] : 'N/A'}",),
                shape: OutlineInputBorder(),
                leading: Icon(Icons.account_circle_outlined),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: Card(
              shape: OutlineInputBorder(),
              elevation: 15,
              child: ListTile(
                title: Text(
                  "${userData.isNotEmpty ? userData[0]['email'] : 'N/A'}",),
                shape: OutlineInputBorder(),
                leading: Icon(Icons.email),
              ),
            ),
          ),


          ElevatedButton(onPressed: () {

            setState(() {
              final _googleSignIn=GoogleSignIn();

              _googleSignIn.signOut();

              googleSignInController.signOutGoogle();
              Get.offAll(WelcomeScreen());
            });

          }, child: Text("LogOut"))
        ],
      ),
    );
  }
}
