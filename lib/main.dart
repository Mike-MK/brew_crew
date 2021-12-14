import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  
  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return  MaterialApp(home: Text('Something went wrong'));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<MUser?>(
            lazy: false,
            //find better flow
            initialData: MUser(uid:'init'),
            create:(context) => AuthService().user,
            child: MaterialApp(
              theme: ThemeData(primaryColor: Colors.brown,accentColor: Colors.brown[900]),
              home: Wrapper(),
              ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(home: Scaffold(body: Loading(),));
      },
    );   
  }
}