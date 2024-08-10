import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:room_finder/presentation/components/base_panel.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RenterPanel extends BaseModalPanel {
  final BuildContext context;
  final TextEditingController nameController;
  final TextEditingController studiesController;
  final TextEditingController interestsController;
  final DateTime selectedDate;

  const RenterPanel(
      {super.key,
      required this.context,
      required super.title,
      required super.btnLabel,
      required super.onBtnPressed,
      required this.nameController,
      required this.studiesController,
      required this.interestsController,
      required super.onBtnClosed,
      required this.selectedDate});

  @override
  Widget get items => Column(
        children: [
          _InputFieldItem(
            itemTitle: AppLocalizations.of(context)!.lblRenterName,
            hint: AppLocalizations.of(context)!.lblEnterName,
            controller: nameController,
          ),
          _InputFieldItem(
            itemTitle: AppLocalizations.of(context)!.lblStudies,
            hint: AppLocalizations.of(context)!.lblEnterStudies,
            controller: studiesController,
          ),
          _InputFieldItem(
            itemTitle: AppLocalizations.of(context)!.lblInterests,
            hint: AppLocalizations.of(context)!.lblEnterInterests,
            controller: interestsController,
          ),
          _DatePickerItem(
            itemTitle: AppLocalizations.of(context)!.lblContractDeadline,
            selectedDate: selectedDate,
          )
        ],
      );
}

class _InputField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;

  const _InputField({required this.hint, required this.controller});

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.aliceBlue,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: TextField(
            // TODO: on text entered
            controller: widget.controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
            ),
          ),
        ),
      ),
    );
  }
}

class _InputFieldItem extends PanelItem {
  final String hint;
  final TextEditingController controller;

  const _InputFieldItem(
      {required super.itemTitle, required this.hint, required this.controller});

  @override
  Widget get content => _InputField(hint: hint, controller: controller);
}

// ignore: must_be_immutable
class _DatePicker extends StatefulWidget {
   DateTime selectedDate;
  _DatePicker({required this.selectedDate});

  @override
  State<_DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<_DatePicker> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  late String _dateFormatted = _dateFormat.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ElevatedButton.icon(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: widget.selectedDate,
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2100),
                ).then((DateTime? value) {
                  if (value != null) {
                    setState(() {
                      widget.selectedDate = value;
                      _dateFormatted = _dateFormat.format(widget.selectedDate);
                    });
                  }
                });
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(_dateFormatted),
            ),
          ),
        ),
      ],
    );
  }
}

class _DatePickerItem extends PanelItem {
  final DateTime selectedDate;

  const _DatePickerItem({required super.itemTitle, required this.selectedDate});

  @override
  Widget get content => _DatePicker(selectedDate: selectedDate);
}
