import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchbrandImages();

  }

  // Creating RxList to store image URLs from Firestore
  RxList<String> BrandImages = RxList<String>([]);

  // Method to fetch carosel images from Firestore collection
  fetchbrandImages() async {
    try {
      // Connecting to collection
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('brand-images')
          .get();

      // Check if the collection is not empty
      if (snapshot.docs.isNotEmpty) {
        BrandImages.value = snapshot.docs
            .map((document) => document['image'] as String)
            .toList();
      }
    } catch (e) {
      print("Error fetching images: $e");
    }
  }

}