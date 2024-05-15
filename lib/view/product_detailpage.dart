import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDetailScreen({Key? key, required this.productData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Display product image
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              child: Image.network(
                productData['image'] ?? '',
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Display product details
            Text(
              '${productData['brand'] ?? ''} ${productData['model'] ?? ''}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Price: \$${productData['price'] ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text('Fuel Type: ${productData['fueltype'] ?? ''}'),
            SizedBox(height: 10),
            Text('Transmission: ${productData['transmission'] ?? ''}'),
            SizedBox(height: 10),

            Text('Mileage: ${productData['mileage'] ?? ''}'),
            SizedBox(height: 10),

            Wrap(
              spacing: 5.w,
              children: (productData['color'] as List<dynamic> ?? [])
                  .map<Widget>((color) {
                return Material(
                  borderRadius: BorderRadius.circular(20),
                  // Same border radius as the Chip
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    // Same border radius as the Chip
                    onTap: () {
                      // Handle onTap event
                    },
                    child: Chip(
                      label: Text(
                        color.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   height: 70.h,
                //   width: 150.w,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor:
                //       Colors.yellow.shade900, // Change the color here
                //     ),
                //     onPressed: () {
                //       // Add to cart functionality
                //     },
                //     child: Text(
                //       'Add to Cart',
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 70.h,
                  width: 150.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.green.shade700, // Change the color here
                    ),
                    onPressed: () {
                      addToCart(productData);
                    },
                    child: Text(
                      'Buy Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }

  // Function to add product to cart
  void addToCart(Map<String, dynamic> productData) {
    CollectionReference cartCollection =
    FirebaseFirestore.instance.collection('cart');
    cartCollection.add(productData);
    // You can add additional functionality here, such as showing a snackbar confirming the addition to cart
  }
}