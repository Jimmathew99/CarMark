import 'package:flutter/material.dart';
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
        elevation: 10,


      ),
      body: Column(
        children: [
          Card(
            child: Text("Introducing the Tesla Model 3: an electric marvel redefining the driving experience. "
                "With a sleek design and advanced electric propulsion, it boasts a range of up to 350 miles per charge. "
                "Inside, the minimalist interior offers spacious seating for five and a panoramic glass roof. "
                "Experience thrilling performance with dual-motor all-wheel drive and Tesla's Autopilot technology for enhanced safety. "
                "Join the electric revolution with the Tesla Model 3."),
          )
          

        ],
      ),

    );
  }
}
