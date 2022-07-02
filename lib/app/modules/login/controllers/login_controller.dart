import 'dart:convert';

import 'package:academiapp/app/model/user_model.dart';
import 'package:academiapp/app/routes/app_pages.dart';
import 'package:academiapp/app/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var user = UserModel().obs;

  var mapUser = {};

  final box = GetStorage();

  UserCredential? userCredential;
  var isAuth = false.obs;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> firstInitialize() async {
    // var dataUser = [];
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
        if (box.read(AppConstant.BOX_AUTO_LOGIN) != null) {
          isAuth.value = box.read(AppConstant.BOX_AUTO_LOGIN);
        }
      }
    });
    if (box.read(AppConstant.BOX_ADD_USER) != null) {
      mapUser = box.read(AppConstant.BOX_ADD_USER);
    }
  }

  Future<bool> autoLogin() async {
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        await _googleSignIn.signInSilently().then((value) {
          return _currentUser = value;
        });
        final googleAuth = await _currentUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        CollectionReference users =
            firestore.collection(AppConstant.COLLECTION_USER);
        final currUser = await users.doc(_currentUser!.email).get();
        final currentUserData = currUser.data() as Map<String, dynamic>;

        user(UserModel.fromJson(currentUserData));

        user.refresh();

        return true;
      }
    } catch (e) {
      print(e.toString());

      return false;
    }
    return false;
  }

  Future<void> login() async {
    try {
      isAuth.value = false;
      isLoading.value = true;
      await _googleSignIn.signOut();
      await _googleSignIn.signIn().then((value) => _currentUser = value);

      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        isLoading.value = true;
        final googleAuth = await _currentUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await _firebaseAuth
            .signInWithCredential(credential)
            .then((value) => userCredential = value);
        CollectionReference users =
            await firestore.collection(AppConstant.COLLECTION_USER);
        final checkUser = await users.doc(_currentUser!.email).get();

        if (checkUser.data() == null) {
          //add or set to firebase
          await users.doc(_currentUser!.email).set(
            {
              "uid": userCredential!.user!.uid,
              "name":
                  userCredential!.additionalUserInfo!.profile!["given_name"],
              "email": _currentUser!.email,
              "keyName":
                  _currentUser!.displayName!.substring(0, 1).toUpperCase(),
              "photoUrl": _currentUser!.photoUrl ?? "noImage",
              "creationTime": userCredential!.user!.metadata.creationTime!
                  .toIso8601String(),
              "status": "Lecturer",
            },
          );
        } else {
          print("data else ${box.read(AppConstant.BOX_AUTO_LOGIN)}");

          print("Something wrong else");
        }
        final currUser = await users.doc(_currentUser!.email).get();

        final currentUserData = currUser.data() as Map<String, dynamic>;

        user(UserModel.fromJson(jsonDecode(jsonEncode(currentUserData))));

        box.write(AppConstant.BOX_ADD_USER, user);
        user.refresh();

        isAuth.value = true;
        box.write(AppConstant.BOX_AUTO_LOGIN, true);

        isLoading.value = false;
        update();

        Get.offNamedUntil(Routes.MAIN, (route) => false);
      } else {
        isLoading.value = false;
        print("Error");
      }
    } catch (error) {
      isLoading.value = false;
      print("error $error");
    }
  }
}
