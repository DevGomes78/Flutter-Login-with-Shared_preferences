import 'package:flutter/material.dart';
import '../constants/string_constants_login.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: buildCenter(),
    );
  }

  Container buildCenter() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [(Colors.deepPurple), (Colors.black54)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/git.png',
                color: Colors.white,
                height: 220,
              ),
              const SizedBox(height: 150),
              const Text(
                StringConstants.aguarde,
                style: TextStyle(color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
