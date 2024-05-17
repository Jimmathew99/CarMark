import 'package:carmark/view/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> productData;

  const ProductDetailScreen({Key? key, required this.productData})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _showProductDetails = false;
  double _totalAmount = 0.0;
  bool _isBooked = false;
  bool _isFavorite = false; // Initialize _isFavorite to false

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchFavoriteStatus();

    });
    // Fetch favorite status from Firestore
  }

  // Function to fetch favorite status from Firestore
  Future<void> fetchFavoriteStatus() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productData['pid'])
          .get();

      if (snapshot.exists) {
        setState(() {
          _isFavorite = snapshot['isFavorite'] ?? false;
        });
      }
    } catch (error) {
      print('Error fetching favorite status: $error');
      // Handle error and set _isFavorite to false
      setState(() {
        _isFavorite = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Display product image
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Image.network(
                widget.productData['image'] ?? '',
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Display product details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.productData['brand'] ?? ''} ${widget.productData['model'] ?? ''}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () async {
                    // Toggle favorite status
                    setState(() {
                      _isFavorite = !_isFavorite; // Use null check operator (!)
                    });
                    // Update Firestore document to mark as favorite
                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(widget.productData['pid'])
                        .update({'isFavorite': _isFavorite});
                  },
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite?Colors.red:null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Price: \$${widget.productData['price'] ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            Text('Description: ${widget.productData['description'] ?? ''}',style: TextStyle(
              fontSize: 14,
            ), ),
            SizedBox(height: 10),
            Text('Fuel Type: ${widget.productData['fueltype'] ?? ''}'),
            SizedBox(height: 10),
            Text('Transmission: ${widget.productData['transmission'] ?? ''}'),
            SizedBox(height: 10),
            Text('Mileage: ${widget.productData['mileage'] ?? ''}'),
            SizedBox(height: 20),
            if (_showProductDetails)
              ProductDetailsCard(
                productData: widget.productData,
                totalAmount: _totalAmount,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 70,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      _isBooked ? Colors.grey : Colors.green.shade700,
                    ),
                    onPressed: _isBooked
                        ? null
                        : () async {
                      setState(() {
                        _showProductDetails = true;
                        _isBooked = true; // Set booked to true
                      });
                      await placeOrderAndGetTotalAmount(
                          widget.productData, context);
                    },
                    child: Text(
                      'Book Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      _isBooked ? Colors.green.shade700 : Colors.grey,
                    ),
                    onPressed: _isBooked
                        ? () async {
                      // Navigate to payment page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(),
                        ),
                      );
                    }
                        : null,
                    child: Text(
                      'Payment',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to place order and get total amount
  Future<void> placeOrderAndGetTotalAmount(
      Map<String, dynamic> productData, BuildContext context) async {
    double price = double.parse(productData['price'].toString());
    double salesTax = 0.025; // 2.5% sales tax
    double totalAmount = price * (1 + salesTax);

    final orderCollection = FirebaseFirestore.instance.collection('orders');

    // Check if the item already exists in the orders collection
    final querySnapshot =
    await orderCollection.where('pid', isEqualTo: productData['pid']).get();

    if (querySnapshot.docs.isNotEmpty) {
      // Item already exists in orders collection
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have already purchased this item.'),
          duration: Duration(seconds: 2),
        ),
      );
      // Set the _showProductDetails state to false
      setState(() {
        _showProductDetails = false;
      });
    } else {
      // Item doesn't exist, add it to the collection
      await orderCollection
          .add({...productData, 'totalAmount': totalAmount}).then((value) {
        print('Product added to orders successfully!');
        setState(() {
          _totalAmount = totalAmount;
        });

        // Add a delay before showing the product card

        setState(() {
          _showProductDetails = true;
        });
      }).catchError((error) => print('Error adding product to orders: $error'));
    }
  }
}

// Card widget to display product details
class ProductDetailsCard extends StatelessWidget {
  final Map<String, dynamic> productData;
  final double totalAmount;

  const ProductDetailsCard({
    Key? key,
    required this.productData,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Invoice",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "CarMark",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Brand/Model : ${productData['brand'] ?? ''} ${productData['model'] ?? ''}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Price: \$${productData['price'] ?? ''}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Sales Tax: 2.5%',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}