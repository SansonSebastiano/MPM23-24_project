import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/wizard_screens/wizard_page6.dart';

class WizardPage5 extends StatelessWidget {
  const WizardPage5({super.key});

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
        leftButton: DarkBackButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        rightButton: CancelButton(onPressed: () {
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
        rightButtonVisibility: true,
        screenTitle: AppLocalizations.of(context)!.lblSetMonthlyRent,
        screenContent: const _WizardPage5Body(),
        dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard5,
        currentStep: 5,
        btnNextLabel: AppLocalizations.of(context)!.btnNext,
        onNextPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WizardPage6()),
          );
        },
        onOkDialog: () => Navigator.of(context).pop());
  }
}

class _WizardPage5Body extends StatefulWidget {
  const _WizardPage5Body();

  @override
  State<_WizardPage5Body> createState() => _WizardPage5BodyState();
}

class _WizardPage5BodyState extends State<_WizardPage5Body> {
  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.w,
              ),
            ),
            child: Text(
              "${_currentSliderValue.round().toString()} €",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 70.sp,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Slider(
              inactiveColor: Colors.grey,
              value: _currentSliderValue,
              max: 1000,
              divisions: 100,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
