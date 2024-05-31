import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final String navigateTo;

  LoadingScreen({required this.navigateTo});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay (e.g., 3 seconds) before navigating to the next screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, widget.navigateTo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/icon.png',
              width: 700,
              height: 600,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
