import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String? _userUid;

  @override
  void initState() {
    super.initState();
    fetchUserUid();
  }

  Future<void> fetchUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _userUid = user?.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: _userUid == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('is-favorite')
            .where('uid', isEqualTo: _userUid)
            .where('isFavorite', isEqualTo: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final favoriteDocs = snapshot.data!.docs;
            if (favoriteDocs.isEmpty) {
              return Center(child: Text('No favorite items found.'));
            }

            return ListView.builder(
              itemCount: favoriteDocs.length,
              itemBuilder: (context, index) {
                final favorite = favoriteDocs[index].data() as Map<String, dynamic>;
                final productId = favorite['pid'];

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('products').doc(productId).get(),
                  builder: (context, productSnapshot) {
                    if (productSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (productSnapshot.hasError) {
                      return Center(child: Text('Error: ${productSnapshot.error}'));
                    } else if (!productSnapshot.hasData || !productSnapshot.data!.exists) {
                      return Center(child: Text('Product not found.'));
                    } else {
                      final productData = productSnapshot.data!.data() as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                productData['image1'] ?? '',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Brand: ${productData['brand']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Model: ${productData['model']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Price: \$${productData['price']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  favorite['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                                  color: favorite['isFavorite'] ? Colors.red : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
