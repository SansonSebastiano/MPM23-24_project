import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'buttons/circle_buttons.dart';

class RoomOption extends StatefulWidget {
  const RoomOption({super.key, required this.roomName});

  final String roomName;

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
            if(widget.roomName !="Beds") SizedBox(width: 15.w),
            Text(
              widget.roomName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
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
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
        if (widget.roomName == 'Bedrooms')
          ...List.generate(
            counter,
            (index) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bedroom ${index + 1}', style: const TextStyle(fontSize: 18)),
                      const Divider(endIndent: 20),
                      const RoomOption(roomName: 'Beds'),
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