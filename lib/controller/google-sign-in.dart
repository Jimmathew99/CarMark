import 'package:carmark/view/home_page.dart';
import 'package:carmark/view/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/usr_model.dart';
import '../view/welcome_screen.dart';

class GoogleController extends GetxController{
final GoogleSignIn googleSignIn=GoogleSignIn();
final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
final _googleSignIn=GoogleSignIn();
Rx<User?> user = Rx<User?>(null);

Future<void> signInWithGoogle() async {
  // final GetDeviceTokenController getDeviceTokenController =
  // Get.put(GetDeviceTokenController());
  try {
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      // EasyLoading.show(status: "Please wait..");
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential userCredential =
      await firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;
      await saveSession(true);
      if (user != null) {
        UserModel userModel = UserModel(
          uId: user.uid,
          username: user.displayName.toString(),
          email: user.email.toString(),
          phone: user.phoneNumber.toString(),
          userImg: user.photoURL.toString(),
          // userDeviceToken: getDeviceTokenController.deviceToken.toString(),
          country: '',
          userAddress: '',
          // street: '',
          // isAdmin: false,
          // isActive: true,
          createdOn: DateTime.now(),
          // city: '',
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(userModel.toMap());
        // EasyLoading.dismiss();
        Get.offAll(() => const HomePage());
      }
    }
  } catch (e) {
    // EasyLoading.dismiss();
    print("error $e");
  }
}
Future<void> signOutGoogle() async {
  try {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    user(null); // Assuming that `user` is a function to update the user state
    print("User Signed Out");
    await saveSession(false);
    Get.offAll(() =>
    const WelcomeScreen()); // Use Get.offAll to navigate to MainScreen
  } catch (e) {
// Handle any errors that occurred during sign out
    print("Error signing out: $e");
  }

}
Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

Future<void> saveSession(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}
}
