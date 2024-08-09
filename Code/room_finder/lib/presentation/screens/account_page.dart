import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/account_photo.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/bottom_bar.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/buttons/setting_buttons.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none, // Allows elements to be positioned outside the container
            children: [
              Container(
                height: 220.h, // Adjust height to control how much of the image is inside the blue box
                decoration: BoxDecoration(
                  color: ColorPalette.darkConflowerBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r),
                  ),
                ),
              ),
              Positioned(
                top: 60.h,
                right: 20.w,
                child: LogoutButton(onPressed: () => showOptionsDialog(
                  context: context, 
                  androidDialog: ActionsAndroidDialog(
                    title: AppLocalizations.of(context)!.btnLogout, 
                    content: AppLocalizations.of(context)!.logoutAlertMessage,
                    // TODO: handle logout
                    onOk: () => {
                      print("logout from RoomFinder..."),
                      Navigator.pop(context)
                    },
                    onCancel: () => Navigator.pop(context)
                  ), 
                  iosDialog: ActionsIosDialog(
                    title: AppLocalizations.of(context)!.btnLogout, 
                    content: AppLocalizations.of(context)!.logoutAlertMessage,
                    // TODO: handle logout
                    onOk: () => {
                      print("logout from RoomFinder..."),
                      Navigator.pop(context)
                    },
                    onCancel: () => Navigator.pop(context)
                  ))
                ),
              ),
              Positioned(
                top: 120.h, // This controls how much of the image is outside the top blue box
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    AccountPhoto(
                      size: 180.r, 
                      imageUrl: "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-per-foto-uomo-selfie.jpg",
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Francesco',
                      style: Theme.of(context).textTheme.displayMedium
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'francescoo@gmail.com',
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 170.h), // Space the body of the page from the top container
          Divider(
            color: ColorPalette.blueberry,
            indent: 25.w,
            endIndent: 25.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 35.w, top: 15.h), 
            child: Align(
              alignment: Alignment.centerLeft, 
              child: Text(
                AppLocalizations.of(context)!.lblSettings,
                style: TextStyle(
                  color: ColorPalette.oxfordBlue,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SettingButtons(
                  onPressed: () => {},
                  label: AppLocalizations.of(context)!.btnPersonalInfo,
                  icon: Icons.person_outline,
                ),
                SettingButtons(
                  onPressed: () => {},
                  label: AppLocalizations.of(context)!.btnLoginSecurity,
                  icon: Icons.login,
                ),
              ],
            ),
          ),
        ],
      ),
      // TODO: check if the current user is host or student
      bottomNavigationBar: const StudentNavigationBar() 
    );
  }
}
