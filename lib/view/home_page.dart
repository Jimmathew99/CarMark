import 'package:cached_network_image/cached_network_image.dart';
import 'package:carmark/controller/carosel-controller.dart';
import 'package:carmark/controller/image-controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carmark/view/category_page.dart';
import 'package:carmark/view/signin_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/get-user-data-controller.dart';
import '../controller/google-sign-in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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


  //Creating object for caroselcontroller to get carosel images from firestore
  CaroselController caroselController = Get.put(CaroselController());
  int currentindex = 0;
  ImageController imageController=Get.put(ImageController());
  int imageindex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(


              icon: Icon(
                Icons.home_filled,
              ),
              backgroundColor: Colors.white30,
              label: "Home"),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,

              ),

              backgroundColor: Colors.black,
              label: "Favorites"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Orders"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "Settings"),
        ]),
        drawer: Drawer(
          elevation: 10,
          child: SafeArea(
            child: Column(
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
                Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: ListTile(
                    title: Text("Order History"),
                    leading: Icon((Icons.shopping_cart)),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: ListTile(
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    trailing: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signin(),
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: ListTile(
                    title: Text("Category"),
                    leading: Icon(Icons.category),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryScreen(),
                          ));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [

            Obx(
                  () {
                if (caroselController.caroselImages.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return CarouselSlider.builder(
                    itemCount: caroselController.caroselImages.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Image.network(
                          caroselController.caroselImages[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    options: CarouselOptions(
                        height: 375.h,
                        scrollDirection: Axis.horizontal,
                        disableCenter: true,
                        autoPlay: true),
                  );
                }
              },
            ),

            Padding(
              padding: const EdgeInsets.all(20.0).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text("Make",style: TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,



                  ),)
                ],
              ),
            ),
            Obx(
                  () {
                if (imageController.BrandImages.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return CarouselSlider.builder(
                    itemCount: imageController.BrandImages.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Image.network(
                          imageController.BrandImages[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    options: CarouselOptions(
                        height: 60.h,
                        scrollDirection: Axis.horizontal,
                        disableCenter: true,),
                  );
                }
              },
            ),




          ]),
        ));
  }
}
