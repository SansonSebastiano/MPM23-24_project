import 'package:flutter/material.dart';
import 'package:room_finder/presentation/components/bottom_bar.dart';

abstract class BaseTemplateScreen extends StatelessWidget {
  const BaseTemplateScreen({super.key});

  bool get isHost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Center(
          // TODO: Add the body of the screen, pay attention to the top components on the different mockup screens
          child: Column(
            children: [],
          ),
        ),
      ),
      bottomNavigationBar: isHost ? const HostNavigationBar() : const StudentNavigationBar(),
    );
  }
}

class StudentTemplateScreen extends BaseTemplateScreen {
  const StudentTemplateScreen({super.key});

  @override
  bool get isHost => false;
}

class HostTemplateScreen extends BaseTemplateScreen {
  const HostTemplateScreen({super.key});

  @override
  bool get isHost => true;
}
