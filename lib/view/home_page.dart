import 'package:cached_network_image/cached_network_image.dart';
import 'package:carmark/controller/carosel-controller.dart';
import 'package:carmark/controller/image-controller.dart';
import 'package:carmark/view/orders_page.dart';
import 'package:carmark/view/productlistpage.dart';
import 'package:carmark/view/settings_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carmark/view/product_screen.dart';
import 'package:carmark/view/signin_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/get-user-data-controller.dart';
import '../controller/google-sign-in.dart';
import 'favorites_screen.dart';

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
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
              backgroundColor: Colors.white30,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorites",
              backgroundColor: Colors.white30,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          onTap: (int index) {
            // Handle navigation based on the tapped index
            switch (index) {
              case 0:
              // Navigate to the Home screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                );
                break;
              case 1:
              // Navigate to the Favorites screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
                      (route) => false,
                );
                break;
              case 2:
              // Navigate to the Orders screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersPage()),
                      (route) => false,
                );
                break;
              case 3:
              // Navigate to the Settings screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                      (route) => false,
                );
                break;
            }
          },
        ),

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
                  padding: const EdgeInsets.all(2.0).r,
                  child: ListTile(
                    title: Text("Order History"),
                    leading: Icon((Icons.shopping_cart)),
                    onTap: () {},
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0).r,
                  child: ListTile(
                    title: Text("Products"),
                    leading: Icon(Icons.shopping_basket_outlined),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(),
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0).r,
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
                    onTap: () async {
                      await googleSignInController.signOutGoogle();
                      print("*************** Logged out **************************************");
                    },
                  ),
                ),
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
                  return  Shimmer.fromColors(
                    child: CircularProgressIndicator(),
                    baseColor: Colors.grey,
                    highlightColor: Colors.black38,
                  );
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
                  Text("Brand",style: TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,



                  ),)
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Handle onTap for the first image
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ProductScreen(),),
                            (route) => false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).r,
                      child: Container(
                        height: 70.h,
                        child: Obx(() {
                          if (imageController.BrandImages.isEmpty) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: imageController.BrandImages.length, // Display half of the images
                              itemBuilder: (BuildContext context, int index) {
                                String selectedBrandName = imageController.brandNames[index]; // Accessing brandNames RxList

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductListPage(brand: selectedBrandName),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Image.network(
                                        imageController.BrandImages[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }),
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   child: InkWell(
                //     onTap: () {
                //       // Handle onTap for the second image
                //       Navigator.pushAndRemoveUntil(
                //         context,
                //         MaterialPageRoute(builder: (context) => const ProductScreen(),),
                //             (route) => false,
                //       );
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0).r,
                //       child: Card(
                //         elevation: 10,
                //
                //         child: Container(
                //           height: 60.h,
                //           child: Obx(() {
                //             if (imageController.BrandImages.isEmpty) {
                //               return Center(child: CircularProgressIndicator());
                //             } else {
                //               final startingIndex = imageController.BrandImages.length ~/ 2;
                //               return ListView.builder(
                //                 scrollDirection: Axis.horizontal,
                //                 itemCount: imageController.BrandImages.length ~/ 2, // Display remaining images
                //                 itemBuilder: (BuildContext context, int index) {
                //                   return Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Image.network(
                //                       imageController.BrandImages[startingIndex + index],
                //                       fit: BoxFit.cover,
                //                     ),
                //                   );
                //                 },
                //               );
                //             }
                //           }),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),











          ]),
        ));
  }
}