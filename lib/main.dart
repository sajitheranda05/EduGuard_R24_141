import 'package:eduguard/firebase_options.dart';
import 'package:eduguard/src/bindings/general_bindings.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  //Widget Binding
  final WidgetsBinding widgetsBinding =WidgetsFlutterBinding.ensureInitialized();

  //Getx Storage
  await GetStorage.init();

  //Await splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EduguardLK",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialBinding: GeneralBindings(),
      home: const Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ),
      );
  }
}

