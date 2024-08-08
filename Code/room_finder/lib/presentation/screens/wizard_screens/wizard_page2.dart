import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/base_panel.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/room_option.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/style/color_palette.dart';

class WizardPage2 extends StatelessWidget {
  const WizardPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
        leftButton: DarkBackButton(onPressed: () {}),
        screenLabel: AppLocalizations.of(context)!.lblSetRooms,
        screenContent: const _WizardPage2Body(),
        dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard2,
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
  late bool isButtonEnabled;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    isButtonEnabled = false;
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
      padding: EdgeInsets.symmetric(horizontal: 30.h),
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
                  showModalPanel(
                    context: context,
                    isScrollControlled: false,
                    panel: _AddRoomPanel(
                      context: context,
                      title: AppLocalizations.of(context)!.lblAddNewRoom,
                      btnLabel: AppLocalizations.of(context)!.btnConfirm,
                      // FIXME: onBtnPressed is not working properly: it remains disabled after the text is enteredß
                      onBtnPressed: isButtonEnabled
                          ? () {
                              print(_controller.text);
                              _controller.clear();
                              Navigator.of(context).pop();
                            }
                          : null,
                      onChanged: (value) {
                        print(value);
                        _controller.text.isNotEmpty
                            ? isButtonEnabled = true
                            : isButtonEnabled = false;
                        print(isButtonEnabled);
                        setState(() {});
                      },
                      controller: _controller,
                      // FIXME: onBtnClosed is not working properly
                      onBtnClosed: () {
                        print(_controller.text);
                        _controller.clear();
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _AddRoomPanel extends BaseModalPanel {
  final BuildContext context;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const _AddRoomPanel(
      {required super.title,
      required super.btnLabel,
      required this.context,
      required super.onBtnPressed,
      required this.controller,
      required this.onChanged,
      required super.onBtnClosed});

  @override
  Widget get items => _InputFieldItem(
        itemTitle: AppLocalizations.of(context)!.lblEnterRoomName,
        hint: AppLocalizations.of(context)!.lblEnterRoomName,
        controller: controller,
        onChanged: onChanged,
      );
}

class _InputField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const _InputField(
      {required this.hint, required this.controller, required this.onChanged});

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
            controller: widget.controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
            ),
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}

class _InputFieldItem extends PanelItem {
  final String hint;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const _InputFieldItem(
      {required super.itemTitle,
      required this.hint,
      required this.controller,
      required this.onChanged});

  @override
  Widget get content => _InputField(
        hint: hint,
        controller: controller,
        onChanged: onChanged,
      );
}
