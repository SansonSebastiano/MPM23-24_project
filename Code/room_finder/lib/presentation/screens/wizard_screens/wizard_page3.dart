import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/add_on.dart';
import 'package:room_finder/presentation/components/base_panel.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/renter_box.dart';
import 'package:room_finder/presentation/components/renter_panel.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/style/color_palette.dart';

class WizardPage3 extends StatelessWidget {
  const WizardPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
        leftButton: DarkBackButton(onPressed: () {}),
        rightButton: CancelButton(onPressed: () {}),
        rightButtonVisibility: true,
        screenLabel: AppLocalizations.of(context)!.lblManageRenters,
        screenContent: const _WizardPage3Body(),
        dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard3,
        currentStep: 3,
        btnNextLabel: AppLocalizations.of(context)!.btnNext,
        btnNextOnPressed: () {},
        onOkDialog: () => Navigator.of(context).pop());
  }
}

class _WizardPage3Body extends StatefulWidget {
  const _WizardPage3Body();

  @override
  State<_WizardPage3Body> createState() => _WizardPage3BodyState();
}

class _WizardPage3BodyState extends State<_WizardPage3Body> {
  late TextEditingController nameController;
  late TextEditingController studiesController;
  late TextEditingController interestsController;
  late DateTime selectedDate;

  late int maxRenter;

  final List<RenterBox> _renters = <RenterBox>[];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    studiesController = TextEditingController();
    interestsController = TextEditingController();

    selectedDate = DateTime.now();

    maxRenter = 0;
  }

  @override
  void dispose() {
    nameController.dispose();
    studiesController.dispose();
    interestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
        child: Column(
          children: <Widget>[
            _MaxRenterSetter(
              maxRenter: maxRenter,
            ),
            SizedBox(height: 60.h),
            AddOn(
                label: AppLocalizations.of(context)!.lblAddRenters,
                onPressed: () {
                  print(maxRenter);
                        showModalPanel(
                            context: context,
                            panel: RenterPanel(
                                context: context,
                                title: AppLocalizations.of(context)!
                                    .lblAddEditRenters,
                                btnLabel:
                                    AppLocalizations.of(context)!.btnConfirm,
                                onBtnPressed: () {
                                  setState(() {
                                    _renters.add(HostRenterBox(
                                        name: nameController.text,
                                        facultyOfStudies:
                                            studiesController.text,
                                        interests: interestsController.text,
                                        contractDeadline: selectedDate,
                                        // TODO: change this
                                        age: 0,
                                        // TODO: complete these methods
                                        onEditPressed: () {},
                                        onRemovePressed: () {
                                          // remove this renter from the list
                                        }));
                                  });

                                  nameController.clear();
                                  studiesController.clear();
                                  interestsController.clear();

                                  Navigator.of(context).pop();
                                },
                                nameController: nameController,
                                studiesController: studiesController,
                                interestsController: interestsController,
                                selectedDate: selectedDate,
                                onBtnClosed: () {
                                  nameController.clear();
                                  studiesController.clear();
                                  interestsController.clear();
                                  Navigator.of(context).pop();
                                }));
                      }),
            SizedBox(height: 30.h),
            Expanded(
              child: ListView.separated(
                  itemCount: _renters.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.h); // Add padding between items
                  },
                  itemBuilder: (context, index) {
                    return _renters[index];
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _MaxRenterSetter extends StatefulWidget {
  int maxRenter;
  _MaxRenterSetter({required this.maxRenter});

  @override
  State<_MaxRenterSetter> createState() => _MaxRenterSetterState();
}

class _MaxRenterSetterState extends State<_MaxRenterSetter> {
  // TODO: move this to the parent widget, because the maxRenters is a state of the parent widget and not of this widget
  // in order to make disable the add renter's button when the maxRenter is reached
  @override
  void initState() {
    super.initState();
    widget.maxRenter = 0;
  }

  void _increment() {
    setState(() {
      widget.maxRenter++;
    });
    print(widget.maxRenter);
  }

  void _decrement() {
    setState(() {
      if (widget.maxRenter > 0) widget.maxRenter--;
    });
    print(widget.maxRenter);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AddRemoveButton(isAddButton: false, size: 30, onPressed: _decrement),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorPalette.oxfordBlue,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
            child: Text("${widget.maxRenter}"),
          ),
        ),
        AddRemoveButton(isAddButton: true, size: 30, onPressed: _increment),
      ],
    );
  }
}
