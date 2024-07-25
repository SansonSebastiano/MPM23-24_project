import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/style/color_palette.dart';

abstract class CustomButton extends StatelessWidget {
  final void Function() onPressed;

  const CustomButton({
    super.key,
    required this.onPressed,
  });

  Color get buttonColor;
  IconData get icon;
  Color get iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 4.r,
            blurRadius: 60.r,
          )
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const CircleBorder(),
          minimumSize: Size(50.w, 50.h), // Fixed dimensions
        ),
        onPressed: onPressed,
        child: Icon(icon, color: iconColor, size: 37.w),
      ),
    );
  }
}

//Light version of Back button
class LightBackButton extends CustomButton {
  const LightBackButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.aliceBlue;

  @override
  IconData get icon => Icons.arrow_back;

  @override
  Color get iconColor => ColorPalette.darkConflowerBlue;
}

//Dark version of Back button
class DarkBackButton extends CustomButton {
  const DarkBackButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.darkConflowerBlue;

  @override
  IconData get icon => Icons.arrow_back;

  @override
  Color get iconColor => ColorPalette.aliceBlue;
}

//Filter button
class FilterButton extends CustomButton {
  const FilterButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.darkConflowerBlue;

  @override
  IconData get icon => Icons.filter_alt_outlined;

  @override
  Color get iconColor => ColorPalette.aliceBlue;
}

//Cancel button
class CancelButton extends CustomButton {
  const CancelButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.darkConflowerBlue;

  @override
  IconData get icon => Icons.close;

  @override
  Color get iconColor => ColorPalette.aliceBlue;
}

//Edit button for ads
class EditButton extends CustomButton {
  const EditButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.aliceBlue;

  @override
  IconData get icon => Icons.edit_square;

  @override
  Color get iconColor => ColorPalette.darkConflowerBlue;
}

//Delete button for ads
class DeleteButton extends CustomButton {
  const DeleteButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.aliceBlue;

  @override
  IconData get icon => Icons.delete_outline_outlined;

  @override
  Color get iconColor => Colors.red;
}

// Info button


// Add/Remove button



// Logout button



//Like button to save ads
class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  // Widget state
  bool isSaved = false;

  Color buttonColor = ColorPalette.aliceBlue;
  IconData icon = Icons.bookmark_border_outlined;
  Color iconColor = ColorPalette.darkConflowerBlue;

  void _toggleSave() {
    setState(() {
      isSaved = !isSaved;  // Toggle the save state
      icon = isSaved ? Icons.bookmark : Icons.bookmark_border_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 60,
          )
        ]
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const CircleBorder(),
          minimumSize: const Size(50, 50), // Fixed dimensions
        ),
        onPressed: _toggleSave,
        child: Icon(icon, color: iconColor, size: 37),
      ),
    );
  }
}