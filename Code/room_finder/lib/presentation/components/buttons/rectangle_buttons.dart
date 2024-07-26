import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/style/color_palette.dart';

class RectangleButton extends StatelessWidget {
  const RectangleButton({super.key, required this.label, required this.onPressed});

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPalette.darkConflowerBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(335.w, 52.h), // Fixed dimensions
      ),
      onPressed: onPressed,
      child: Text(
        label, 
        style: TextStyle(
          color: Colors.white, 
          fontSize: 20.w,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}