import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            // Navigate back
          },
          child: Icon(Icons.arrow_back),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(15.0).r,
              child: Card(
                elevation: 15,
                color: Colors.black,
                child: Container(
                  width: 125.w,
                  height: 210.h,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: Card(
              elevation: 15,
              child: Container(
                width: 125.w,
                height: 210.h,
                color: Colors.blue,
              ),
            ),
          ),


        ],
      ),
    );
  }
}
