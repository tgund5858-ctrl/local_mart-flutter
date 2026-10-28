import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:local_mart/presentation/onBordingScreen.dart';

class Back extends StatefulWidget {
  const Back({super.key});

  @override
  State<Back> createState() => _BackState();
}

class _BackState extends State<Back> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnBordingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Image.asset('assets/images/main_img.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
