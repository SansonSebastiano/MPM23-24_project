import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/bottom_bar.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/buttons/rectangle_buttons.dart';
import 'package:room_finder/presentation/components/input_text_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:room_finder/style/color_palette.dart';
// import 'package:room_finder/util/network_handler.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CancelButton(onPressed: () => Navigator.pop(context)),
                      Center(
                        child: Image(
                          image: const AssetImage('assets/images/RoomFinder-logo.png'),
                          width: 257.5.w,
                          height: 127.h,
                        ),
                      ),
                      SizedBox(height: 40.h), 
                      Text(
                        AppLocalizations.of(context)!.lblLogin,
                        style: Theme.of(context).textTheme.displayMedium
                      ),
                      SizedBox(height: 20.h), 
                      Text(
                        AppLocalizations.of(context)!.lblLoginDesc,
                        style: Theme.of(context).textTheme.bodyLarge
                      ),
                      SizedBox(height: 20.h), 
                      const EmailTextField(),
                      SizedBox(height: 20.h), 
                      const LoginPswdTextField(),
                      SizedBox(height: 30.h), 
                      Center(
                        child: RectangleButton(label: "Log in", onPressed: () => {},),
                      ),
                      SizedBox(height: 20.h), 
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: AppLocalizations.of(context)!.lblNoAccount,
                            style: TextStyle(
                              color: ColorPalette.oxfordBlue,
                              fontSize: 18.sp,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign up',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalette.oxfordBlue,
                                  decoration: TextDecoration.underline
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print("redirect to registration page...");
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const StudentNavigationBar(),
    );
  }
}