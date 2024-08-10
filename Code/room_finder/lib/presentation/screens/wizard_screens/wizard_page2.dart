import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/room_option.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WizardPage2 extends StatelessWidget {
  const WizardPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
        leftButton: DarkBackButton(onPressed: () {}),
        rightButton: CancelButton(onPressed: () {}),
        rightButtonVisibility: true,
        screenLabel: AppLocalizations.of(context)!.lblSetRooms,
        screenContent: const _WizardPage2Body(),
        dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard2,
        onOkDialog: () => Navigator.of(context).pop(),
        currentStep: 2,
        btnNextLabel: AppLocalizations.of(context)!.btnNext,
        btnNextOnPressed: () {});
  }
}

class _WizardPage2Body extends StatefulWidget {
  const _WizardPage2Body();

  @override
  State<_WizardPage2Body> createState() => _WizardPage2BodyState();
}

class _WizardPage2BodyState extends State<_WizardPage2Body> {
  late TextEditingController _controller;
  final List<RoomOption> _rooms = <RoomOption>[];

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
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.lblAddRooms,
                ),
                AddRemoveButton(
                  isAddButton: true,
                  size: 25,
                  onPressed: () {
                    showOptionsDialog(
                        context: context,
                        androidDialog: ActionsAndroidDialog(
                            context: context,
                            title: AppLocalizations.of(context)!.lblAddNewRoom,
                            content: TextField(
                              controller: _controller,
                            ),
                            onCancel: () {
                              _onCancel(context);
                            },
                            onOk: () {
                              _onOk(context);
                            }),
                        iosDialog: ActionsIosDialog(
                            context: context,
                            title: AppLocalizations.of(context)!.lblAddNewRoom,
                            content: CupertinoTextField(
                              controller: _controller,
                            ),
                            onCancel: () {
                              _onCancel(context);
                            },
                            onOk: () {
                              _onOk(context);
                            }));
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.separated(
                  itemCount: _rooms.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return _rooms[index];
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _onOk(BuildContext context) {
    setState(() {
      _rooms.add(RoomOption(
        roomName: _controller.text,
      ));
    });
    _controller.clear();
    Navigator.of(context).pop();
  }

  void _onCancel(BuildContext context) {
    _controller.clear();
    Navigator.of(context).pop();
  }
}
