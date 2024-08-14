import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WizardPage5 extends StatelessWidget {
  const WizardPage5({super.key});

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
        leftButton: DarkBackButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        // TODO: Implement the onPressed function for the right button
        rightButton: CancelButton(onPressed: () {}),
        rightButtonVisibility: true,
        screenLabel: AppLocalizations.of(context)!.lblSetMonthlyRent,
        screenContent: const _WizardPage4Body(),
        dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard5,
        currentStep: 4,
        btnNextLabel: AppLocalizations.of(context)!.btnNext,
        btnNextOnPressed: () {},
        onOkDialog: () => Navigator.of(context).pop());
  }
}

class _WizardPage4Body extends StatefulWidget {
  const _WizardPage4Body();

  @override
  State<_WizardPage4Body> createState() => _WizardPage4BodyState();
}

class _WizardPage4BodyState extends State<_WizardPage4Body> {
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
          Slider(
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
        ],
      ),
    );
  }
}
