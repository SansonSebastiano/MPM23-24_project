import 'dart:io';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_finder/style/color_palette.dart';

/// The class [_AddPhotoButton] is a widget that represents a button to add a photo.
class _AddPhotoButton extends StatelessWidget {
  final void Function()? onPressed;

  const _AddPhotoButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(
          ColorPalette.blueberry.withOpacity(0.5),
        ),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(
            color: ColorPalette.jordyBlue.withOpacity(0.5),
            width: 2.w,
          ),
        ),
        // FIXME: in the smaller screens, the button has not the same defined size as below
        minimumSize: WidgetStateProperty.all<Size>(
          Size(150.w, 150.h),
        ),
        maximumSize: WidgetStateProperty.all<Size>(
          Size(150.w, 150.h),
        ),
        fixedSize: WidgetStateProperty.all<Size>(
          Size(150.w, 150.h),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          ColorPalette.lavenderBlue.withOpacity(0.5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_a_photo),
          Text(AppLocalizations.of(context)!.lblAddPhoto),
        ],
      ),
    );
  }
}

/// [RoomPhoto] is a stateful widget that allows the user to select a photo from
/// the gallery or take a photo with the camera.
/// Then it displays the selected photo into a square card of 150x150.
class RoomPhoto extends StatefulWidget {
  final int photoNumber;
  const RoomPhoto({super.key, required this.photoNumber});

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
  Future showAndroidModal() {
    return showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.lblChooseOption,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Divider(
                  color: ColorPalette.ceruleanBlue.withOpacity(0.8),
                  thickness: 1.h,
                ),
                TextButton.icon(
                  onPressed: () {
                    getImageFromGallery();
                    Navigator.of(context).pop();
                  },
                  label: Text(AppLocalizations.of(context)!.btnGallery),
                  icon: const Icon(Icons.photo),
                ),
                Divider(
                  color: ColorPalette.ceruleanBlue.withOpacity(0.5),
                  thickness: 1.h,
                ),
                TextButton.icon(
                  onPressed: () {
                    getImageFromCamera();
                    Navigator.of(context).pop();
                  },
                  label: Text(AppLocalizations.of(context)!.btnCamera),
                  icon: const Icon(Icons.camera_alt),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show dialog for iOS
  Future showIosModal() async {
    showCupertinoModalPopup(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(AppLocalizations.of(context)!.lblChooseOption),
        actions: [
          CupertinoActionSheetAction(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.photo,
                  color: ColorPalette.darkConflowerBlue,
                ),
                Text(AppLocalizations.of(context)!.btnGallery),
              ],
            ),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.camera_alt,
                  color: ColorPalette.darkConflowerBlue,
                ),
                Text(AppLocalizations.of(context)!.btnCamera),
              ],
            ),
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
      showAndroidModal();
    } else {
      showIosModal();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: display images in a grid of n x 2 (in their own screen)
    return Column(
      children: [
        _AddPhotoButton(
          onPressed: showOptionsDialog,
        ),
        _image == null
            ? const Text('No Image selected')
            : ImageCard(
                image: _image,
                photoNumber: widget.photoNumber,
              ),
      ],
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required File? image,
    required this.photoNumber,
  }) : _image = image;

  final File? _image;
  final int photoNumber;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          child: Image.file(
            _image!,
            fit: BoxFit.cover,
            width: 150.0.w,
            height: 150.0.h,
          ),
        ),
        Positioned(
          top: -20,
          left: -20,
          child: Container(
            width: 20.0.w,
            height: 20.0.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 3.r,
                  blurRadius: 5.r,
                  offset: const Offset(17, 17),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.cancel),
              iconSize: 30.0.w,
              color: Theme.of(context).colorScheme.error,
              onPressed: () {
                // TODO: Remove image
              },
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Card(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.85),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.0.h),
              child: Text(
                "$photoNumber",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
