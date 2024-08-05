import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/buttons/rectangle_buttons.dart';
import 'package:room_finder/presentation/screens/chat_detail_page.dart';
import 'package:room_finder/style/color_palette.dart';

import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => ChatDetailPage(
                  receiverImageUrl:
                      "https://newprofilepic.photo-cdn.net//assets/images/article/profile.jpg?90af0c8",
                  receiverName: "Giorgia Rossi",
                  facilityName: "Casa Dolce Casa",
                  lastMessage: DateTime(2024, 10, 2),
                  onTap: () {},
                )),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IntroScreen()),
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  Future<void> _onStartPressed(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => IntroScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Text(
                'Welcome to RoomFinder!',
                style: TextStyle(
                  fontSize: 24.h,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.oxfordBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              Image(
                image: const AssetImage('assets/images/Welcome-image.png'),
                width: 269.w,
                height: 251.h,
              ),
              const Spacer(flex: 2),
              Text(
                'Are you a student looking for a home or a host who wants to make his apartment available?',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorPalette.oxfordBlue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                'This is the place for you!',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorPalette.oxfordBlue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                'Use RoomFinder to create or search for the most suitable solutions for you and to fully enjoy university life in your city.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorPalette.oxfordBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              RectangleButton(
                label: "Let's start",
                onPressed: () => _onStartPressed(context),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
