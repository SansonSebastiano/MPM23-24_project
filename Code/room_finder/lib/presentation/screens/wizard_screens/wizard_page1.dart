import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/wizard_screens/wizard_page2.dart';

class WizardPage1 extends StatefulWidget {
  const WizardPage1({super.key});

  @override
  State<WizardPage1> createState() => _WizardPage1State();
}

class _WizardPage1State extends State<WizardPage1> {
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
              }
            ),
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
              }
            )
          );
      }),
      screenTitle: AppLocalizations.of(context)!.lblAddress,
      currentStep: 1,
      btnNextLabel: AppLocalizations.of(context)!.btnNext,
      dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard1,
      onOkDialog: () => Navigator.of(context).pop(),
      onNextPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WizardPage2()),
        );
      },
      screenContent: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
          child: const Column(
            children: <Widget>[
              // form fields
            ],
          ),
        ),
      ),
    );
  }
}
