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

// Back button (Light version)
class LightBackButton extends CustomButton {
  const LightBackButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.aliceBlue;

  @override
  IconData get icon => Icons.arrow_back;

  @override
  Color get iconColor => ColorPalette.oxfordBlue;
}

// Back button (Dark version)
class DarkBackButton extends CustomButton {
  const DarkBackButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.oxfordBlue;

  @override
  IconData get icon => Icons.arrow_back;

  @override
  Color get iconColor => ColorPalette.aliceBlue;
}

// Filter button
class FilterButton extends CustomButton {
  const FilterButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.oxfordBlue;

  @override
  IconData get icon => Icons.filter_alt_outlined;

  @override
  Color get iconColor => ColorPalette.aliceBlue;
}

// Cancel button
class CancelButton extends CustomButton {
  const CancelButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.oxfordBlue;

  @override
  IconData get icon => Icons.close;

  @override
  Color get iconColor => ColorPalette.aliceBlue;
}

// Edit button
class EditButton extends CustomButton {
  const EditButton({super.key, required super.onPressed});

  @override
  Color get buttonColor => ColorPalette.aliceBlue;

  @override
  IconData get icon => Icons.edit_square;

  @override
  Color get iconColor => ColorPalette.oxfordBlue;
}

// Delete button
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
class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.size,
    required this.onPressed,
  });

  final double size;
  final void Function() onPressed;

  final Color buttonColor = ColorPalette.aliceBlue;
  final IconData icon = Icons.question_mark;
  final Color iconColor = ColorPalette.oxfordBlue;

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
        ]
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const CircleBorder(),
          minimumSize: Size(size, size),
        ),
        onPressed: onPressed,
        child: Icon(icon, color: iconColor, size: size-5),
      ),
    );
  }
}

// Add/Remove button
class AddRemoveButton extends StatelessWidget {
  const AddRemoveButton({
    super.key,
    required this.isAddButton,
    required this.size,
    required this.onPressed,
  });

  final bool isAddButton;
  final double size;
  final void Function() onPressed;

  final Color buttonColor = ColorPalette.aliceBlue;
  final IconData icon = Icons.add;
  final Color iconColor = ColorPalette.oxfordBlue;

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
        ]
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const CircleBorder(
            side: BorderSide(
              color: ColorPalette.oxfordBlue, 
              width: 2,
            ),
          ),
          minimumSize: Size(size, size),
        ),
        onPressed: onPressed,
        child: Icon(isAddButton ? Icons.add : Icons.remove, color: iconColor, size: size-5),
      ),
    );
  }
}

// Logout button
class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  final Color buttonColor = Colors.white;
  final IconData icon = Icons.logout_outlined;
  final Color iconColor = Colors.red;

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
        ]
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize: Size(127.w, 42.h),
          maximumSize: Size(127.w, 42.h),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Logout', style: TextStyle(color: Colors.red),),
            SizedBox(width: 8.w),
            Icon(icon, color: iconColor, size: 24.w),
          ]
        )
      ),
    );
  }
}

// Bookmark button
class BookmarkButton extends StatefulWidget {
  const BookmarkButton({super.key});

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  // Widget state
  bool isSaved = false;

  Color buttonColor = ColorPalette.aliceBlue;
  IconData icon = Icons.bookmark_border_outlined;
  Color iconColor = ColorPalette.oxfordBlue;

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
            spreadRadius: 4.r,
            blurRadius: 60.r,
          )
        ]
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const CircleBorder(),
          minimumSize: Size(50.w, 50.h), // Fixed dimensions
        ),
        onPressed: _toggleSave,
        child: Icon(icon, color: iconColor, size: 37.w),
      ),
    );
  }
}