import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/account_photo.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/buttons/setting_buttons.dart';
import 'package:room_finder/presentation/screens/account_page_login_security.dart';
import 'package:room_finder/presentation/screens/account_page_personal_information.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipPath(
              clipper: EllipseClipper(),
              child: Container(
                height: 300.h,
                color: ColorPalette.darkConflowerBlue,
              ),
            ),
            Positioned(
              top: 60.h,
              right: 20.w,
              child: LogoutButton(
                  onPressed: () => showOptionsDialog(
                      context: context,
                      androidDialog: ActionsAndroidDialog(
                          context: context,
                          title: AppLocalizations.of(context)!.btnLogout,
                          content: Text(AppLocalizations.of(context)!
                              .logoutAlertMessage),
                          onOk: () => {
                                print("logout from RoomFinder..."),
                                Navigator.pop(context)
                              },
                          onCancel: () => Navigator.pop(context)),
                      iosDialog: ActionsIosDialog(
                          context: context,
                          title: AppLocalizations.of(context)!.btnLogout,
                          content: Text(AppLocalizations.of(context)!
                              .logoutAlertMessage),
                          onOk: () => {
                                print("logout from RoomFinder..."),
                                Navigator.pop(context)
                              },
                          onCancel: () => Navigator.pop(context)))),
            ),
            Positioned(
              top: 120.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  AccountPhoto(
                    size: 180.r,
                    imageUrl:
                        "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-per-foto-uomo-selfie.jpg",
                  ),
                  SizedBox(height: 10.h),
                  Text('Francesco',
                      style: Theme.of(context).textTheme.displayMedium),
                  SizedBox(height: 10.h),
                  Text('francescoo@gmail.com',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 100.h),
        Divider(
          color: ColorPalette.blueberry,
          indent: 25.w,
          endIndent: 25.w,
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.w, top: 15.h, bottom: 15.h),
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
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Column(
            children: [
              SettingButtons(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            const PersonalInformationPage())),
                label: AppLocalizations.of(context)!.btnPersonalInfo,
                icon: Icons.person_outline,
              ),
              SettingButtons(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const LoginSecurityPage())),
                label: AppLocalizations.of(context)!.btnLoginSecurity,
                icon: Icons.login,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EllipseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Start the path at the left edge, somewhat lower on the container's height
    path.moveTo(0, size.height * 0.6);

    // Create a quadratic bezier curve that defines the ellipse
    // The first point is the control point for the curve
    // The second point is the end point of the curve on the right edge
    path.quadraticBezierTo(
        size.width / 2,
        size.height * 0.8, // This makes the curve flatter
        size.width,
        size.height * 0.6); // End point at the same level as the start point

    // Draw lines to close the shape
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
