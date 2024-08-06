import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/bottom_bar.dart';

/// [MainTemplateScreen] is an abstract class that represents the main template screen.
///
/// Implementing this class will create a screen with a bottom navigation bar.
///
/// The [isHost] getter is used to determine if the user is a host or a student, to differentiate the bottom navigation bar accordingly.
///
/// The [title] getter is used to set the title of the screen.
///
/// The [content] getter is used to set the content of the screen.
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

/// [StudentTemplateScreen] is a class that represents the student template screen.
///
/// This class extends [MainTemplateScreen] and sets the [isHost] getter to false.
///
/// The [screenLabel] is used to set the title of the screen.
///
/// The [screenContent] is used to set the content of the screen.
class StudentTemplateScreen extends MainTemplateScreen {
  final String screenLabel;
  final Widget screenContent;

  const StudentTemplateScreen(
      {super.key, required this.screenLabel, required this.screenContent});

  @override
  bool get isHost => false;

  @override
  String get title => screenLabel;

  @override
  Widget get content => screenContent;
}

/// [HostTemplateScreen] is a class that represents the host template screen.
///
/// This class extends [MainTemplateScreen] and sets the [isHost] getter to true.
///
/// The [screenLabel] is used to set the title of the screen.
///
/// The [screenContent] is used to set the content of the screen.
class HostTemplateScreen extends MainTemplateScreen {
  final String screenLabel;
  final Widget screenContent;

  const HostTemplateScreen(
      {super.key, required this.screenLabel, required this.screenContent});

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
/// 
/// Implementing this class will create a screen without a bottom navigation bar.
/// 
/// The [leftHeaderWidget] is the widget placed on the left side of the header.
/// 
/// The [centerHeaderWidget] is the widget placed in the center of the header.
/// 
/// The [rightHeaderWidget] is the widget placed on the right side of the header.
/// 
/// The [rightHeaderWidgetVisibility] is used to determine if the right widget is visible or not, default is false. And in case it is false, the portion of the header where the right widget is placed will not empty. If [rightHeaderWidget] will be not passed and [rightHeaderWidgetVisibility] will be set to true, nothing will be shown.
class SecondaryTemplateScreen extends StatelessWidget {
  final Widget leftHeaderWidget;
  final Widget centerHeaderWidget;
  final Widget? rightHeaderWidget;
  final bool rightHeaderWidgetVisibility;

  const SecondaryTemplateScreen({super.key, required this.leftHeaderWidget, required this.centerHeaderWidget, this.rightHeaderWidget, this.rightHeaderWidgetVisibility = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              _ScreenHeader(
                leftWidget: leftHeaderWidget,
                centerWidget: centerHeaderWidget,
                rightWidget: rightHeaderWidget,
                rightWidgetVisibility: rightHeaderWidgetVisibility,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [_ScreenHeader] is a class that represents the header of a screen withouth a bottom navigation bar.
///
/// The header is composed by a [leftWidget], a [centerWidget] and an optional [rightWidget].
///
/// [leftWidget] is the widget placed on the left side of the header.
///
/// [centerWidget] is the widget placed in the center of the header.
///
/// [rightWidget] is the widget placed on the right side of the header.
///
/// [rightWidgetVisibility] is used to determine if the right widget is visible or not, default is false. And in case it is false, the portion of the header where the right widget is placed will not empty.
class _ScreenHeader extends StatelessWidget {
  final Widget leftWidget;
  final Widget centerWidget;
  final Widget? rightWidget;
  final bool rightWidgetVisibility;

  const _ScreenHeader(
      {required this.leftWidget,
      required this.centerWidget,
      // ignore: unused_element
      this.rightWidget,
      // ignore: unused_element
      this.rightWidgetVisibility = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: leftWidget,
          ),
          Expanded(
            flex: 2,
            child: Align(alignment: Alignment.center, child: centerWidget),
          ),
          Expanded(
              flex: 1,
              child: Visibility(
                visible: rightWidgetVisibility,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: rightWidget ?? const SizedBox.shrink(),
              )),
        ],
      ),
    );
  }
}
