import 'package:app2/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    _navigateToMainScreen();
  }
Future<void> _navigateToMainScreen() async{
  await Future.delayed(const Duration(seconds: 3),);
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => MainScreen()),
  );
}

  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.black,

      body: Center(child : Text('NETFLIX' , style: TextStyle(color: Colors.red ,fontWeight: FontWeight.w500, fontSize: 35 ),),),
    );
  }
}