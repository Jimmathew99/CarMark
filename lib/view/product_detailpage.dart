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
          ]),
        ));
  }
}