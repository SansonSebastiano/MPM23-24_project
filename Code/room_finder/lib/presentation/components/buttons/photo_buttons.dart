import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/style/color_palette.dart';

/// The class [AddPhotoButton] is a widget that represents a button to add a photo.
class AddPhotoButton extends StatelessWidget {
  final void Function()? onPressed;

  const AddPhotoButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(
          ColorPalette.blueberry.withOpacity(0.5),
        ),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(
            color: ColorPalette.jordyBlue.withOpacity(0.5),
            width: 2.w,
          ),
        ),
        // FIXME: in the smaller screens, the button has not the same defined size as below
        minimumSize: WidgetStateProperty.all<Size>(
          Size(150.w, 150.h),
        ),
        maximumSize: WidgetStateProperty.all<Size>(
          Size(150.w, 150.h),
        ),
        fixedSize: WidgetStateProperty.all<Size>(
          Size(150.w, 150.h),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          ColorPalette.lavenderBlue.withOpacity(0.5),
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo),
          Text('Add photo'),
        ],
      ),
    );
  }
}
