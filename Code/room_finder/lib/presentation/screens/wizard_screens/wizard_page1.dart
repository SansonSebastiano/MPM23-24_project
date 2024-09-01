import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/model/ad_model.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/input_text_fields.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/wizard_screens/wizard_page2.dart';

class WizardPage1 extends StatefulWidget {
  const WizardPage1({super.key});

  @override
  State<WizardPage1> createState() => _WizardPage1State();
}

class _WizardPage1State extends State<WizardPage1> {
  late TextEditingController _cityController;
  late TextEditingController _streetController;

  bool _isCityValid = false;
  bool _isStreetValid = false;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    _streetController = TextEditingController();
  }

  @override
  void dispose() {
    _cityController.dispose();
    _streetController.dispose();
    super.dispose();
  }

  void _onCityValidityChanged(bool isValid) {
    setState(() {
      _isCityValid = isValid;
    });
  }

  void _onAddressValidityChanged(bool isValid) {
    setState(() {
      _isStreetValid = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
      leftButton: CancelButton(onPressed: () {
        showOptionsDialog(
            context: context,
            androidDialog: ActionsAndroidDialog(
                title: AppLocalizations.of(context)!.lblWarningTitleDialog,
                content: Text(AppLocalizations.of(context)!.lblCancelWizard),
                context: context,
                onOk: () {
                  // TODO: Replace with the real data
                  backToHostHomePage(context);
                },
                onCancel: () {
                  Navigator.of(context).pop();
                }),
            iosDialog: ActionsIosDialog(
                title: AppLocalizations.of(context)!.lblWarningTitleDialog,
                content: Text(AppLocalizations.of(context)!.lblCancelWizard),
                context: context,
                onOk: () {
                  // TODO: Replace with the real data
                  backToHostHomePage(context);
                },
                onCancel: () {
                  Navigator.of(context).pop();
                }));
      }),
      screenTitle: AppLocalizations.of(context)!.lblAddress,
      currentStep: 1,
      btnNextLabel: AppLocalizations.of(context)!.btnNext,
      dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard1,
      onOkDialog: () => Navigator.of(context).pop(),
      onNextPressed: (_isCityValid && _isStreetValid)
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WizardPage2(address: Address(street: _streetController.text, city: _cityController.text),)),
              );
            }
          : null,
      screenContent: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Image(
                    image: const AssetImage('assets/images/Address-form.png'),
                    width: 200.w,
                    height: 200.h,
                  ),
                ),
                SizedBox(height: 20.h),
                StandardTextField(
                    label: AppLocalizations.of(context)!.lblCity,
                    onValueValidityChanged: _onCityValidityChanged,
                    controller: _cityController,
                ),
                SizedBox(height: 20.h),
                StandardTextField(
                    label: AppLocalizations.of(context)!.lblStreet,
                    onValueValidityChanged: _onAddressValidityChanged,
                    controller: _streetController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
