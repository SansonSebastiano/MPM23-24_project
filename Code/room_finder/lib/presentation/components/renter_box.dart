import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The class [RenterBox] defines a widget that represents a current renter for a specific facility.
/// The widget is characterized by the following parameters:
/// - [name];
/// - [age];
/// - [interests];
/// - [facultyOfStudies];
/// - [contractDeadline] that determines the end of renter's current contract;
/// - [hostView], to allow or not editing on renters' information;
/// - [onRemovePressed] to define the remove functionality;
/// - [onEditPressed] to define the editing functionality.
class RenterBox extends StatelessWidget {
  final String name;
  final int age;
  final String facultyOfStudies;
  final String interests;
  final DateTime contractDeadline;
  final bool hostView;
  final void Function()? onEditPressed;
  final void Function()? onRemovePressed;

  const RenterBox(
      {super.key,
      required this.name,
      required this.age,
      required this.facultyOfStudies,
      required this.interests,
      required this.contractDeadline,
      required this.hostView,
      this.onEditPressed,
      this.onRemovePressed});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(contractDeadline);

    return Center(
      child: Container(
        width: 349.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorPalette.lavenderBlue,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.h,
                color: ColorPalette.oxfordBlue,
              ),
            ),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.lblRenterAge,
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.oxfordBlue,
                ),
                children: [
                  TextSpan(
                    text: '$age',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.lblRenterStudies,
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.oxfordBlue,
                ),
                children: [
                  TextSpan(
                    text: facultyOfStudies,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.lblRenterInterests,
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.oxfordBlue,
                ),
                children: [
                  TextSpan(
                    text: interests,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.lblRenterContract,
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.oxfordBlue,
                ),
                children: [
                  TextSpan(
                    text: formattedDate,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            if (hostView) ...[
              SizedBox(
                height: 20.h,
              ),
              const Divider(
                color: ColorPalette.oxfordBlue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      onRemovePressed!();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.btnRemove,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onEditPressed!();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.btnEdit,
                      style: TextStyle(
                        color: ColorPalette.oxfordBlue,
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
