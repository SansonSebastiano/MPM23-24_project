import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This class contains the [SwitchTypeAccountButton] widget, which is a switch button that allows the user to select between two predifined options. 
class SwitchTypeAccountButton extends StatefulWidget {
  final void Function() onPressed;
  
  const SwitchTypeAccountButton({super.key, required this.onPressed});

  @override
  State<SwitchTypeAccountButton> createState() => _SwitchTypeAccountButtonState();
}

class _SwitchTypeAccountButtonState extends State<SwitchTypeAccountButton> {
  // Widget state
  bool isStudentSelected = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 335.w,
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.lblAccountType,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.w,
                    color: ColorPalette.oxfordBlue
                  ),
                ),
                InfoButton(size: 30.w, onPressed: widget.onPressed)
              ]
            ),
          ),
          SizedBox(height: 20.h,),
          SizedBox(
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
          )
        ]
      ),
    );
  }
}