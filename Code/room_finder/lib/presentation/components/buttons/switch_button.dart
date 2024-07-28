import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/style/color_palette.dart';

/// This class contains the [SwitchButton] widget, which is a switch button that allows the user to select between two predifined options. 
class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  // Widget state
  bool isStudentSelected = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335.w,
      height: 52.h,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isStudentSelected = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isStudentSelected ? const Color.fromRGBO(24, 60, 129, 80) : const Color.fromRGBO(198, 208, 250, 50),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Student',
                  style: TextStyle(
                    fontSize: 20,
                    color: isStudentSelected ? ColorPalette.aliceBlue : ColorPalette.oxfordBlue,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isStudentSelected = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isStudentSelected ? const Color.fromRGBO(198, 208, 250, 50) : const Color.fromRGBO(24, 60, 129, 80),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Host',
                  style: TextStyle(
                    fontSize: 20,
                    color: isStudentSelected ? ColorPalette.oxfordBlue : ColorPalette.aliceBlue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}