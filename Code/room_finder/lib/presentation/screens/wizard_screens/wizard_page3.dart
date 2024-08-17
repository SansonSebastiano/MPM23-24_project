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
        // TODO: complete the leftButton and rightButton
        leftButton: DarkBackButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        rightButton: CancelButton(onPressed: () {}),
        rightButtonVisibility: true,
        screenTitle: AppLocalizations.of(context)!.lblManageRenters,
        screenContent: const _WizardPage3Body(),
        dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard3,
        currentStep: 3,
        btnNextLabel: AppLocalizations.of(context)!.btnNext,
        // TODO: complete the onPressed function for the next button
        onNextPressed: () {},
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
  late TextEditingController ageController;
  late DateTime selectedDate;

  late int maxRenter;

  final List<RenterBox> _renters = <RenterBox>[];

  // TODO: implement the button active logic: when the user has filled all the fields
  // bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    studiesController = TextEditingController();
    // ..addListener(_checkButtonActive);
    interestsController = TextEditingController();
    // ..addListener(_checkButtonActive);
    ageController = TextEditingController();

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

  void _increment() {
    setState(() {
      maxRenter++;
    });
  }

  void _decrement() {
    setState(() {
      if (maxRenter > 0) maxRenter--;
    });
  }

  bool _isMaxRenterReached() {
    return maxRenter == 0 || maxRenter == _renters.length;
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
              onAddPressed: _increment,
              onRemovePressed: _decrement,
            ),
            SizedBox(height: 60.h),
            AddOn(
                label: AppLocalizations.of(context)!.lblAddRenters,
                // disable the button when the maxRenter is reached or when the maxRenter is 0
                onPressed: _isMaxRenterReached()
                    ? null
                    : () {
                        // show the panel to add a new renter
                        _addNewRenter(context);
                      }),
            SizedBox(height: 30.h),
            Expanded(
              child: ListView.separated(
                  itemCount: _renters.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.h); // Add padding between items
                  },
                  itemBuilder: (context, index) {
                    return HostRenterBox(
                      name: _renters[index].name,
                      age: _renters[index].age,
                      facultyOfStudies: _renters[index].facultyOfStudies,
                      interests: _renters[index].interests,
                      contractDeadline: _renters[index].contractDeadline,
                      onEditPressed: () {
                        // set the text fields with the current values
                        nameController.text = _renters[index].name;
                        studiesController.text =
                            _renters[index].facultyOfStudies!;
                        interestsController.text = _renters[index].interests!;
                        selectedDate = _renters[index].contractDeadline;
                        ageController.text = _renters[index].age.toString();
                        // show the panel to edit the fields
                        _editRenter(context, index);
                      },
                      // remove the renter from the list
                      onRemovePressed: () {
                        setState(() {
                          _renters.removeAt(index);
                        });
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _editRenter(BuildContext context, int index) {
    return showModalPanel(
        context: context,
        panel: RenterPanel(
            context: context,
            title: AppLocalizations.of(context)!.lblAddEditRenters,
            btnLabel: AppLocalizations.of(context)!.btnConfirm,
            onDateChanged: (DateTime? date) {
              setState(() {
                selectedDate = date!;
              });
            },
            onBtnPressed: () {
              setState(() {
                _renters[index] = HostRenterBox(
                  name: nameController.text,
                  facultyOfStudies: studiesController.text,
                  interests: interestsController.text,
                  contractDeadline: selectedDate,
                  age: int.parse(ageController.text),
                );
              });

              nameController.clear();
              studiesController.clear();
              interestsController.clear();
              ageController.clear();

              Navigator.of(context).pop();
            },
            nameController: nameController,
            studiesController: studiesController,
            interestsController: interestsController,
            ageController: ageController,
            selectedDate: selectedDate,
            onBtnClosed: () {
              nameController.clear();
              studiesController.clear();
              interestsController.clear();

              Navigator.of(context).pop();
            }));
  }

  Future<dynamic> _addNewRenter(BuildContext context) {
    return showModalPanel(
        context: context,
        panel: RenterPanel(
            context: context,
            title: AppLocalizations.of(context)!.lblAddEditRenters,
            btnLabel: AppLocalizations.of(context)!.btnConfirm,
            onDateChanged: (DateTime? date) {
              setState(() {
                selectedDate = date!;
              });
            },
            onBtnPressed: () {
              setState(() {
                _renters.add(HostRenterBox(
                  name: nameController.text,
                  facultyOfStudies: studiesController.text,
                  interests: interestsController.text,
                  contractDeadline: selectedDate,
                  age: int.parse(ageController.text),
                ));
              });

              nameController.clear();
              studiesController.clear();
              interestsController.clear();
              ageController.clear();

              Navigator.of(context).pop();
            },
            nameController: nameController,
            studiesController: studiesController,
            interestsController: interestsController,
            ageController: ageController,
            selectedDate: selectedDate,
            onBtnClosed: () {
              nameController.clear();
              studiesController.clear();
              interestsController.clear();
              Navigator.of(context).pop();
            }));
  }
}

// ignore: must_be_immutable
class _MaxRenterSetter extends StatefulWidget {
  int maxRenter;
  final void Function() onAddPressed;
  final void Function() onRemovePressed;

  _MaxRenterSetter(
      {required this.maxRenter,
      required this.onAddPressed,
      required this.onRemovePressed});

  @override
  State<_MaxRenterSetter> createState() => _MaxRenterSetterState();
}

class _MaxRenterSetterState extends State<_MaxRenterSetter> {
  @override
  void initState() {
    super.initState();
    widget.maxRenter = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AddRemoveButton(
            isAddButton: false, size: 30, onPressed: widget.onRemovePressed),
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
        AddRemoveButton(
            isAddButton: true, size: 30, onPressed: widget.onAddPressed),
      ],
    );
  }
}
