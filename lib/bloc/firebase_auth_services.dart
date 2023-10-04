import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signUpWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        Get.snackbar("Week password", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use'){
        Get.snackbar("Email already in use", "The password provided is too weak.");
      }
    } catch (e){
      Get.snackbar("Error", "Error occurred");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        Get.snackbar("User not found", "No user found for that email.");
      } else if (e.code == 'wrong-password'){
        Get.snackbar("Wrong password", "Wrong password provided for that user.");
      }
    } catch (e){
      Get.snackbar("Error", "Error occurred");
    }
    return null;
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}