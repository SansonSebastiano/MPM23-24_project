import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/add_on.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/amenities_option.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WizardPage4 extends StatefulWidget {
  const WizardPage4({super.key});

  @override
  State<WizardPage4> createState() => _WizardPage4State();
}

class _WizardPage4State extends State<WizardPage4> {
  late TextEditingController _controller;
  late List<AmenitiesOption> _amenities;
  late Map<String, bool> _amenitiesSwitches;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _amenities = <AmenitiesOption>[];
    _amenitiesSwitches = {};
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _amenitiesSwitches = {
      AppLocalizations.of(context)!.lblWiFi: false,
      AppLocalizations.of(context)!.lblDishwasher: false,
      AppLocalizations.of(context)!.lblWashingMachine: false,
      AppLocalizations.of(context)!.lblDedicatedParking: false,
      AppLocalizations.of(context)!.lblAirConditioning: false,
    };

    _amenities = _amenitiesSwitches.entries
        .map((entry) => AmenitiesOption(
              label: entry.key,
              isChecked: entry.value,
              onChanged: (value) {
                setState(() {
                  _amenitiesSwitches[entry.key] = value;
                });
              },
            ))
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
      leftButton: DarkBackButton(onPressed: () {
        Navigator.of(context).pop();
      }),
      rightButton: CancelButton(onPressed: () {}),
      rightButtonVisibility: true,
      screenTitle: AppLocalizations.of(context)!.lblAmenitieService,
      dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard4,
      currentStep: 4,
      btnNextLabel: AppLocalizations.of(context)!.btnNext,
      onNextPressed: _amenitiesSwitches.values.contains(true) ? () {
        // TODO: Implement this function
      } : null,
      onOkDialog: () => Navigator.of(context).pop(),
      screenContent: Expanded(
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
                    return AmenitiesOption(
                      label: _amenitiesSwitches.keys.elementAt(index),
                      onChanged: (value) {
                        setState(() {
                          _amenitiesSwitches[_amenitiesSwitches.keys.elementAt(index)] = value;
                        });
                      },
                      isChecked: _amenitiesSwitches.values.elementAt(index),
                    );
                  },
                ),
              ),
            ],
          ),
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
      if (_controller.text.isNotEmpty) {
        _amenitiesSwitches.addEntries({_controller.text: true}.entries);
        _amenities.add(AmenitiesOption(
          label: _amenitiesSwitches.keys.last,
          isChecked: _amenitiesSwitches.values.last,
          onChanged: (value) {
            setState(() {
              _amenitiesSwitches[_amenitiesSwitches.keys.last] = value;
            });
          },
        ));
      }
    });
    _controller.clear();
    Navigator.of(context).pop();
  }

  void _onCancel(BuildContext context) {
    _controller.clear();
    Navigator.of(context).pop();
  }
}
