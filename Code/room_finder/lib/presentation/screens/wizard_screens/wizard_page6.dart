import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WizardPage6 extends StatelessWidget {
  const WizardPage6({super.key});

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
        leftButton: DarkBackButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        // TODO: Implement the onPressed function for the right button
        rightButton: CancelButton(onPressed: () {}),
        rightButtonVisibility: true,
        screenLabel: AppLocalizations.of(context)!.lblAdsTitle,
        screenContent: const _WizardPage4Body(),
        dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard6,
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
    return Expanded(
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
    ));
  }
}
