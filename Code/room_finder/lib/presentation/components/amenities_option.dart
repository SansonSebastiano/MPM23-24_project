import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmenitiesOption extends StatefulWidget {
  const AmenitiesOption({super.key});

  @override
  State<AmenitiesOption> createState() => _AmenitiesOptionState();
}

class _AmenitiesOptionState extends State<AmenitiesOption> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 33.w, right: 33.w),
      child: Row(
        children: [
          const Text("data"),
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
    );
  }
}
