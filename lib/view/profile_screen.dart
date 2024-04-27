import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            backgroundImage: AssetImage('images/smilingperson.jpg'),
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
                title: Text("Name:"),
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
                title: Text("Email:"),
                shape: OutlineInputBorder(),
                leading: Icon(Icons.email),
              ),
            ),
          )
        ],
      ),
    );
  }
}
