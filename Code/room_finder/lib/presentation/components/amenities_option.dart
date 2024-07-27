import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/style/color_palette.dart';

/// The class [AmenitiesOption] is a widget that represents an option for the amenities that a room can have.
/// It contains a label and a checkbox to select the option.
class AmenitiesOption extends StatefulWidget {
  final String label;

  const AmenitiesOption({super.key, required this.label});

  @override
  State<AmenitiesOption> createState() => _AmenitiesOptionState();
}

class _AmenitiesOptionState extends State<AmenitiesOption> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 33.w, right: 33.w),
          child: Row(
            children: [
              Text(widget.label),
              const Spacer(),
              Checkbox(
                value: isChecked,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ],
          ),
        ),
        Divider(
          indent: 30.w,
          endIndent: 30.w,
          color: ColorPalette.blueberry,
        ),
      ],
    );
  }
}
