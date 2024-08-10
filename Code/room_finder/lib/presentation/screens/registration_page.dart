import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/buttons/rectangle_buttons.dart';
import 'package:room_finder/presentation/components/buttons/switch_type_account_button.dart';
import 'package:room_finder/presentation/components/input_text_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/components/snackbar.dart';
import 'package:room_finder/util/network_handler.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});
  
  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isNameValid = false;

  String accountTypeInfo = "In RoomFinder you can find two types of account: \n\n• Student: select it if you are looking for an accomodation in your city of studies. \n\n• Host: select it if you are interested in making available your spaces, creating rental proposals for future students. \n\nStudent type is the preselected option, so if you are a Student it is not necessary to select anything, otherwise select Host option.";

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

  void _handleRegistration() {
    if (_isEmailValid && _isPasswordValid) {
      final networkStatus = ref.read(networkAwareProvider);

      if (networkStatus == NetworkStatus.off) {
        showErrorSnackBar(context, "No internet connection. Please try again.");
      } else {
        // Proceed with registration logic
        print("registering user...");
      }
    }
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
                      SwitchTypeAccountButton(onPressed: () => showOptionsDialog(
                        context: context, 
                        androidDialog: InfoAndroidDialog(
                          title: AppLocalizations.of(context)!.lblAccountType, 
                          content: Text(accountTypeInfo)
                        ), 
                        iosDialog: InfoIosDialog(
                          title: AppLocalizations.of(context)!.lblAccountType, 
                          content: Text(accountTypeInfo)
                        ))
                      ),
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
                              onPressed: _handleRegistration,
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