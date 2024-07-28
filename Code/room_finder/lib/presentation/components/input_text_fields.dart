import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This file contains the implementation of all input fields belonging to the app forms.

/// The class [NameTextField] defines an input field to digit the name of a user.  
class NameTextField extends StatefulWidget {
  const NameTextField({super.key});

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  // Widget state
  late TextEditingController _controller;
  bool _isNameEmpty = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.lblName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.w,
            color: ColorPalette.oxfordBlue
          ),
        ),
        SizedBox(height: 8.h,),
        if (_isNameEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              'The Name field cannot be empty',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        Container(
          width: 335.w,
          height: 52.h,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(198, 208, 250, 50),
            borderRadius: BorderRadius.all(Radius.circular(8.0),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: '',
            ),
            style: const TextStyle(color: ColorPalette.oxfordBlue),
            onSubmitted: (String value) {
              setState(() {
                _isNameEmpty = value.isEmpty;
              });

              if (!_isNameEmpty) {
                print('Submitted text: $value');
              }
            },
          )
        ),
      ],
    );
  }
}