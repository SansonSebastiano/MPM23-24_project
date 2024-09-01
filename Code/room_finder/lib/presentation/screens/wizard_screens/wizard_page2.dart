import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/model/ad_model.dart';
import 'package:room_finder/presentation/components/add_on.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/room_option.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/wizard_screens/wizard_page3.dart';

class WizardPage2 extends StatelessWidget {
  final Address address;

  const WizardPage2({super.key, required this.address});

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
        screenTitle: AppLocalizations.of(context)!.lblSetRooms,
        screenContent: const _WizardPage2Body(),
        dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard2,
        onOkDialog: () => Navigator.of(context).pop(),
        currentStep: 2,
        btnNextLabel: AppLocalizations.of(context)!.btnNext,
        onNextPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WizardPage3()),
          );
        });
  }
}

class _WizardPage2Body extends StatefulWidget {
  const _WizardPage2Body();

  @override
  State<_WizardPage2Body> createState() => _WizardPage2BodyState();
}

class _WizardPage2BodyState extends State<_WizardPage2Body> {
  late TextEditingController _controller;
  late List<RoomOption> _rooms;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _rooms = <RoomOption>[];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rooms = <RoomOption>[
      RoomOption(roomName: AppLocalizations.of(context)!.lblBathrooms),
      RoomOption(roomName: AppLocalizations.of(context)!.lblKitchens),
      RoomOption(roomName: AppLocalizations.of(context)!.lblLivingRoom),
      RoomOption(roomName: AppLocalizations.of(context)!.lblBedrooms),
    ];
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
            AddOn(
                label: AppLocalizations.of(context)!.lblAddRooms,
                onPressed: () {
                  _addRoom(context);
                }),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.separated(
                  itemCount: _rooms.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.h); // Add padding between items
                  },
                  itemBuilder: (context, index) {
                    print(_rooms[index].counter);
                    return _rooms[index];
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _addRoom(BuildContext context) {
    return showOptionsDialog(
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
