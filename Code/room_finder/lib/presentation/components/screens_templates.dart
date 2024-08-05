import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/bottom_bar.dart';

/// [MainTemplateScreen] is an abstract class that represents the main template screen.
///
/// Implementing this class will create a screen with a bottom navigation bar.
abstract class MainTemplateScreen extends StatelessWidget {
  const MainTemplateScreen({super.key});

  bool get isHost;
  String get title;
  Widget get content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 30.h, bottom: 30.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title,
                      style: Theme.of(context).textTheme.displayMedium),
                ),
              ),
              content,
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          isHost ? const HostNavigationBar() : const StudentNavigationBar(),
    );
  }
}

class StudentTemplateScreen extends MainTemplateScreen {
  final String screenLabel;
  final Widget screenContent;

  const StudentTemplateScreen({super.key, required this.screenLabel, required this.screenContent});

  @override
  bool get isHost => false;

  @override
  String get title => screenLabel;

  @override
  Widget get content => screenContent;
}

class HostTemplateScreen extends MainTemplateScreen {
  final String screenLabel;
  final Widget screenContent;

  const HostTemplateScreen({super.key, required this.screenLabel, required this.screenContent});

  @override
  bool get isHost => true;

  @override
  String get title => screenLabel;

  @override
  Widget get content => screenContent;
}

/// [SecondaryTemplateScreen] is an abstract class that represents the secondary template screen.
///
/// The one that does not have a bottom navigation bar.
abstract class SecondaryTemplateScreen extends StatelessWidget {
  const SecondaryTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          // TODO: Add the body of the screen, pay attention to the top components on the different mockup screens
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
