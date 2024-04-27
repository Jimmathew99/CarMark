import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carmark/view/category_page.dart';
import 'package:carmark/view/signin_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = ['images/Cybertruck.jpg', 'images/Model3.jpg'];

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
                  backgroundImage: AssetImage('images/smilingperson.jpg'),
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
        body: Column(children: [
          CarouselSlider(
            items: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'images/lambo1.jpg',
                    height: 100.h,
                    width: 125.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'images/lambo2.jpg',
                    height: 100.h,
                    width: 125.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'images/lambo3.jpg',
                    height: 100.h,
                    width: 125.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 375.h,
              scrollDirection: Axis.horizontal,
              disableCenter: true,
              enableInfiniteScroll: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Best Sellers",style: TextStyle(
                  fontWeight: FontWeight.bold,

                ),),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 50.h,
                  width: 80.w,
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),

                );
              },
            ),
          ),
          Text("Tesla CyberTruck")
        ]));
  }
}
