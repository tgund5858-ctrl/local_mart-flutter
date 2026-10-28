import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';
import 'package:local_mart/const/appTextStyles.dart';
import 'package:local_mart/const/widgets/custom_button.dart';
import 'package:local_mart/presentation/locationScreen.dart';
import 'package:lottie/lottie.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  int currentPage = 0;

  final PageController _controller = PageController();

  final List<String> animation = [
    'assets/main.json',
    "assets/bussnuss.json",
    'assets/Stickmen _ Business.json',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.appBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildScroll(),

              SizedBox(height: 20),

              _buildTextAnimation(),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [dot(0), dot(1), dot(2)],
              ),

              SizedBox(height: 20),

              CustomButton(
                text: "Next",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Locationscreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextAnimation() {
    return Column(
      children: [
        Text("Shop Local", style: Apptextstyles.headingLarge),
        Text("Support Local", style: Apptextstyles.headingLarge),

        SizedBox(height: 10),

        AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              "Discover amazing products",
              textStyle: Apptextstyles.bodyLarge,
              speed: Duration(milliseconds: 150),
            ),
          ],
        ),

        AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              "nearby shops in your area",
              textStyle: Apptextstyles.bodyLarge,
              speed: Duration(milliseconds: 150),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScroll() {
    return Expanded(
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: PageView.builder(
          controller: _controller,
          itemCount: animation.length,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return Center(child: Lottie.asset(animation[index]));
          },
        ),
      ),
    );
  }

  Widget dot(int index) {
    return Container(
      margin: EdgeInsets.all(4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Appcolors.darkBlue
            : Appcolors.secondaryText,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
