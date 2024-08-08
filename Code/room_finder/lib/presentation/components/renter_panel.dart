import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:room_finder/presentation/components/base_panel.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RenterPanel extends BaseModalPanel {
  final BuildContext context;

  const RenterPanel(
      {super.key,
      required this.context,
      required super.title,
      required super.btnLabel,
      required super.onBtnPressed});

  @override
  Widget get items => Column(
        children: [
          _InputFieldItem(
            itemTitle: AppLocalizations.of(context)!.lblRenterName,
            hint: AppLocalizations.of(context)!.lblEnterName,
          ),
          _InputFieldItem(
            itemTitle: AppLocalizations.of(context)!.lblStudies,
            hint: AppLocalizations.of(context)!.lblEnterStudies,
          ),
          _InputFieldItem(
            itemTitle: AppLocalizations.of(context)!.lblInterests,
            hint: AppLocalizations.of(context)!.lblEnterInterests,
          ),
          _DatePickerItem(
            itemTitle: AppLocalizations.of(context)!.lblContractDeadline,
          )
        ],
      );
}

class _InputField extends StatefulWidget {
  final String hint;

  const _InputField({required this.hint});

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
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
            controller: _controller,
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

  const _InputFieldItem({required super.itemTitle, required this.hint});

  @override
  Widget get content => _InputField(hint: hint);
}

class _DatePicker extends StatefulWidget {
  const _DatePicker();

  @override
  State<_DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<_DatePicker> {
  DateTime _selectedDate = DateTime.now();
  String _dateFormatted = DateFormat('dd/MM/yyyy').format(DateTime.now());

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
                  initialDate: _selectedDate,
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2100),
                ).then((DateTime? value) {
                  if (value != null) {
                    setState(() {
                      _selectedDate = value;
                      _dateFormatted =
                          DateFormat('dd/MM/yyyy').format(_selectedDate);
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
  const _DatePickerItem({required super.itemTitle});

  @override
  Widget get content => const _DatePicker();
}
