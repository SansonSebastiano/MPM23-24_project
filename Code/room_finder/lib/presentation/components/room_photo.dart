import 'dart:io';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_finder/presentation/components/buttons/photo_buttons.dart';

class RoomPhoto extends StatefulWidget {
  const RoomPhoto({super.key});

  @override
  State<RoomPhoto> createState() => _RoomPhotoState();
}

class _RoomPhotoState extends State<RoomPhoto> {
  File? _image;
  final picker = ImagePicker();

  // Getting image from gallery
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Getting image from camera
  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Show dialog for android
  Future showAndroidDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.lblChooseOption),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text(AppLocalizations.of(context)!.btnGallery),
                  onTap: () {
                    getImageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text(AppLocalizations.of(context)!.btnCamera),
                  onTap: () {
                    getImageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show dialog for iOS
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(AppLocalizations.of(context)!.lblChooseOption),
        actions: [
          CupertinoActionSheetAction(  
            child: Text(AppLocalizations.of(context)!.btnGallery),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context)!.btnCamera),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  // Show dialog based on platform
  void showOptionsDialog() {
    if (Theme.of(context).platform == TargetPlatform.android) {
      showAndroidDialog();
    } else {
      showOptions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddPhotoButton(
            onPressed: showOptionsDialog,
          ),
          // TODO: display images cropped in a square shape of 150x150 in a matrix of n x 2
          Center(
            child: _image == null ? const Text('No Image selected') : Image.file(_image!),
          ),
      ],
    );
  }
}
