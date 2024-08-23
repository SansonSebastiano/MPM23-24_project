import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/model/authentication_model.dart';
import 'package:room_finder/model/user_model.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/buttons/rectangle_buttons.dart';
import 'package:room_finder/presentation/components/buttons/switch_type_account_button.dart';
import 'package:room_finder/presentation/components/input_text_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/components/snackbar.dart';
import 'package:room_finder/presentation/screens/login_page.dart';
import 'package:room_finder/provider/authentication_provider.dart';
import 'package:room_finder/util/network_handler.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _pswdController;
  late TextEditingController _confirmPswdController;

  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isNameValid = false;

  bool _isStudentSelected = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _pswdController = TextEditingController();
    _confirmPswdController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _pswdController.dispose();
    _confirmPswdController.dispose();
    super.dispose();
  }

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
        // TODO: see issue #35
        showErrorSnackBar(context, "No internet connection. Please try again.");
      } else {
        // Proceed with registration logic
        ref.read(authNotifierProvider.notifier).signup(
            userCredential: AuthArgs(
                email: _emailController.text, password: _pswdController.text),
            user: UserData(name: _nameController.text, isHost: _isStudentSelected));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
          orElse: () => null,
          authenticated: (user) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
            // FIXME: bug on showing the correct snackbar, currently is shown, after clicked signup button, the snackbar with login message
            showSuccessSnackBar(
                context, AppLocalizations.of(context)!.lblSuccessfulSignup);
          },
          unauthenticated: (message) => showErrorSnackBar(
              context, AppLocalizations.of(context)!.lblFailedSignup));
    });

    return Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DarkBackButton(onPressed: () => Navigator.pop(context)),
                      SizedBox(height: 40.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.lblRegistration,
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                            SizedBox(height: 20.h),
                            SwitchTypeAccountButton(
                              onInfo: () => showOptionsDialog(
                                  context: context,
                                  androidDialog: ActionsAndroidDialog(
                                      context: context,
                                      title: AppLocalizations.of(context)!
                                          .lblAccountType,
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .accountTypeAlertMessage),
                                      onOk: () => Navigator.pop(context)),
                                  iosDialog: ActionsIosDialog(
                                      context: context,
                                      title: AppLocalizations.of(context)!
                                          .lblAccountType,
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .accountTypeAlertMessage),
                                      onOk: () => Navigator.pop(context))),
                              onStudent: () {
                                setState(() {
                                  _isStudentSelected = true;
                                });
                              },
                              onHost: () {
                                setState(() {
                                  _isStudentSelected = false;
                                });
                              },
                              isStudentSelected: _isStudentSelected,
                            ),
                            SizedBox(height: 20.h),
                            StandardTextField(
                                label: AppLocalizations.of(context)!.lblName,
                                onValueValidityChanged: _onNameValidityChanged,
                                controller: _nameController,
                            ),
                            SizedBox(height: 20.h),
                            EmailTextField(
                              onEmailValidityChanged: _onEmailValidityChanged,
                              controller: _emailController,
                            ),
                            SizedBox(height: 20.h),
                            RegistrationPswdTextField(
                              onPswdValidationChanged:
                                  _onPasswordValidityChanged,
                              pswdController: _pswdController,
                              confirmPswdController: _confirmPswdController,
                            ),
                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        persistentFooterButtons: [
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
        ]);
  }
}
