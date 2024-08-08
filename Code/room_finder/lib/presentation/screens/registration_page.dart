import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/buttons/rectangle_buttons.dart';
import 'package:room_finder/presentation/components/buttons/switch_type_account_button.dart';
import 'package:room_finder/presentation/components/input_text_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:room_finder/util/network_handler.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isNameValid = false;

  void _onEmailValidityChanged(bool isValid) {
    setState(() {
      _isEmailValid = isValid;
    });
  }

  void _onPasswordValidityChanged(bool isValid) {
    setState(() {
      _isPasswordValid = isValid;
    });
  }

  void _onNameValidityChanged(bool isValid) {
    setState(() {
      _isNameValid = isValid;
    });
  }

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
                      SizedBox(height: 40.h),
                      Text(AppLocalizations.of(context)!.lblRegistration,
                          style: Theme.of(context).textTheme.displayMedium),
                      SizedBox(height: 20.h),
                      SwitchTypeAccountButton(onPressed: () => {}),
                      SizedBox(height: 20.h),
                      NameTextField(onNameValidityChanged: _onNameValidityChanged),
                      SizedBox(height: 20.h),
                      EmailTextField(onEmailValidityChanged: _onEmailValidityChanged),
                      SizedBox(height: 20.h),
                      RegistrationPswdTextField(onPswdValidationChanged: _onPasswordValidityChanged),
                      SizedBox(height: 30.h),
                      Center(
                        child: Stack(
                          children: [
                            RectangleButton(
                              label: "Sign up",
                              onPressed:  () {
                                if (_isNameValid && _isEmailValid && _isPasswordValid) {
                                  print("Signing up...");
                                }
                              },
                            ),
                            if (!_isNameValid || !_isEmailValid || !_isPasswordValid)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}