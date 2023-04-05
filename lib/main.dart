


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/Model/DatabaseHelper.dart';
import 'package:untitled9/Screens/SearchScreen.dart';
import 'package:untitled9/Screens/FavoriteList.dart';
import 'package:untitled9/Model/Receipt.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>Receipt()),
    ChangeNotifierProvider(create: (context)=>DatabaseHelper3()),


  ],
  child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:SearchScreen()
    );
  }


}


