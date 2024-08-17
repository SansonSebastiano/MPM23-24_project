import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/style/color_palette.dart';
import 'buttons/circle_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The [RoomOption] widget defines the component used during the adding rental proposal process to manage the number of rooms present in a specif facility.
/// When you construct the [RoomOption] widget you need to specify the name of the room that you want to manage.
class RoomOption extends StatefulWidget {
  final String roomName;

  const RoomOption({super.key, required this.roomName});

  int get counter {
    return _RoomOptionState().counter;
  }

  @override
  State<RoomOption> createState() => _RoomOptionState();
}

class _RoomOptionState extends State<RoomOption> {
  // Widget state
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void _decrementCounter() {
    if (counter > 0) {
      setState(() {
        counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if(widget.roomName != AppLocalizations.of(context)!.lblBeds) SizedBox(width: 15.w),
            Text(
              widget.roomName,
              style: TextStyle(fontSize: 22.w, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AddRemoveButton(
                    isAddButton: false,
                    size: 30.w,
                    onPressed: _decrementCounter,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '$counter',
                    style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 10.w),
                  AddRemoveButton(
                    isAddButton: true,
                    size: 30.w,
                    onPressed: _incrementCounter,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (widget.roomName == AppLocalizations.of(context)!.lblBedrooms)
          ...List.generate(
            counter,
            (index) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 32.w, top: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bedroom ${index + 1}', 
                        style: TextStyle(
                          fontSize: 18.w,
                          color: ColorPalette.oxfordBlue
                      )),
                      Divider(
                        endIndent: 20.w,
                        color:  const Color.fromRGBO(78, 128, 240, 47),
                      ),
                      RoomOption(roomName: AppLocalizations.of(context)!.lblBeds),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}