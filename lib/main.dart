import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karate_lecture/SearchScreen/SearchScreen.dart';
import 'package:karate_lecture/Service/Login.dart';
import 'package:karate_lecture/State/OurImageProvider.dart';
import 'package:karate_lecture/State/currentUserdata.dart';
import 'package:karate_lecture/State/getUseruid.dart';
import 'package:karate_lecture/Util/Ourthem.dart';
import 'package:karate_lecture/root/root.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [

      ChangeNotifierProvider(

        create: (context)=>CurrentState (),

      ),
      ChangeNotifierProvider(create: (_)=>UserProvider(),),
      // ChangeNotifierProvider(create: (_)=>OurChannelprovider(),),
      ChangeNotifierProvider<ImageUploadProvider>(
        create: (context)=>ImageUploadProvider(),
      ),

    ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Ourthem().buildTheme(),
        initialRoute: '/',
        routes:{
          '/SearchScreen': (context)=> OurSearchScreen(),
        },
        home: OurRoot(),
      ),
    );
  }
}
