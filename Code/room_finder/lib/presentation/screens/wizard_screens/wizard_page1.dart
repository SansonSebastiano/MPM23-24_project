import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// TODO: google maps integration

class WizardPage1 extends StatelessWidget {
  const WizardPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
      // TODO: complete the leftButton
      leftButton: DarkBackButton(onPressed: () {}),
      screenLabel: AppLocalizations.of(context)!.lblAddress,
      currentStep: 1,
      btnNextLabel: AppLocalizations.of(context)!.btnNext,
      dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard1,
      onOkDialog: () => Navigator.of(context).pop(),
      // TODO: complete the onPressed function for the next button
      btnNextOnPressed: () {}, //() => Navigator.pushNamed(context, '/wizard2'),
      screenContent: const _WizardPage1Body(),
    );
  }
}

class _WizardPage1Body extends StatelessWidget {
  const _WizardPage1Body();
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: const Column(
        children: <Widget>[
        
        ],
      ),
    );
  }
}
