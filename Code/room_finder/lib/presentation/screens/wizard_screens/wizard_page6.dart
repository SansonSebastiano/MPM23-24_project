import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/wizard_screens/wizard_page7.dart';

class WizardPage6 extends StatefulWidget {
  const WizardPage6({super.key});

  @override
  State<WizardPage6> createState() => _WizardPage6State();
}

class _WizardPage6State extends State<WizardPage6> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, TextEditingValue value, _) {
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
                // TODO: Implement the onOk function to come back to the home page (the host version)
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
                // TODO: Implement the onOk function to come back to the home page (the host version)
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const ()),
                // );
              },
              onCancel: () {
                Navigator.of(context).pop();
              }
            )
          );
            }),
            rightButtonVisibility: true,
            screenTitle: AppLocalizations.of(context)!.lblAdsTitle,
            dialogContent:
                AppLocalizations.of(context)!.lblContentDialogWizard6,
            currentStep: 6,
            btnNextLabel: AppLocalizations.of(context)!.btnNext,
            onNextPressed: _controller.value.text.isEmpty
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WizardPage7()),
                    );
                  },  
            onOkDialog: () => Navigator.of(context).pop(),
            screenContent: Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
                child: Column(
                  children: [
                    TextField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.multiline,
                      maxLength: 50,
                      maxLines: 4,
                      controller: _controller,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.lblEnterTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }
}
