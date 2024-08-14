import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/add_on.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/amenities_option.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WizardPage4 extends StatelessWidget {
  const WizardPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
        leftButton: DarkBackButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        rightButton: CancelButton(onPressed: () {}),
        rightButtonVisibility: true,
        screenLabel: AppLocalizations.of(context)!.lblAmenitieService,
        screenContent: const _WizardPage4Body(),
        dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard4,
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
  // TODO: initialize the list of rooms with some predefined values
  final List<AmenitiesOption> _amenities = <AmenitiesOption>[];

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
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: AddOn(
                label: AppLocalizations.of(context)!.lblAddService,
                onPressed: () {
                  _addService(context);
                },
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.separated(
                itemCount: _amenities.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 5.h); // Add padding between items
                },
                itemBuilder: (context, index) {
                  return _amenities[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addService(BuildContext context) {
    return showOptionsDialog(
                  context: context,
                  androidDialog: ActionsAndroidDialog(
                      title: AppLocalizations.of(context)!.lblAddNewService,
                      content: TextField(
                        controller: _controller,
                      ),
                      context: context,
                      onOk: () => _onOk(context),
                      onCancel: () => _onCancel(context)),
                  iosDialog: ActionsIosDialog(
                      title: AppLocalizations.of(context)!.lblAddNewService,
                      content: CupertinoTextField(
                        controller: _controller,
                      ),
                      context: context,
                      onOk: () => _onOk(context),
                      onCancel: () => _onCancel(context)),
                );
  }

  void _onOk(BuildContext context) {
    setState(() {
      _amenities.add(AmenitiesOption(label: _controller.text));
    });
    _controller.clear();
    Navigator.of(context).pop();
  }

  void _onCancel(BuildContext context) {
    _controller.clear();
    Navigator.of(context).pop();
  }
}
