import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/room_photo.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/facility_detail_page.dart';
import 'package:room_finder/style/color_palette.dart';

class WizardPage7 extends StatefulWidget {
  const WizardPage7({super.key});

  @override
  State<WizardPage7> createState() => _WizardPage7State();
}

class _WizardPage7State extends State<WizardPage7> {
  late File _image;
  final picker = ImagePicker();
  late List<Widget> _gridItems;

  @override
  void initState() {
    super.initState();

    _image = File('');

    _gridItems = [];

    _gridItems.add(
      AddPhotoButton(onPressed: () {
        showImageSelectionOption(
            context: context,
            onGalleryPressed: () {
              // get image from gallery
              getImageFrom(ImageSource.gallery);
              // close the options modal
              Navigator.of(context).pop();
            },
            onCameraPressed: () {
              // get image from camera
              getImageFrom(ImageSource.camera);
              // close the options modal
              Navigator.of(context).pop();
            });
      }),
    );
  }

  // Getting image from [ImageSource source]
  Future<void> getImageFrom(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _gridItems.add(ImageCard(
          image: _image,
          photoNumber: _gridItems.length,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WizardTemplateScreen(
      leftButton: DarkBackButton(onPressed: () {
        Navigator.of(context).pop();
      }),
      rightButton: CancelButton(onPressed: () {
        showOptionsDialog(
            context: context,
            androidDialog: ActionsAndroidDialog(
                title: AppLocalizations.of(context)!.lblWarningTitleDialog,
                content: Text(AppLocalizations.of(context)!.lblCancelWizard),
                context: context,
                onOk: () {
                  // TODO: Replace with the real data
                  backToHostHomePage(context);
                },
                onCancel: () {
                  Navigator.of(context).pop();
                }),
            iosDialog: ActionsIosDialog(
                title: AppLocalizations.of(context)!.lblWarningTitleDialog,
                content: Text(AppLocalizations.of(context)!.lblCancelWizard),
                context: context,
                onOk: () {
                  // TODO: Replace with the real data
                   backToHostHomePage(context);
                },
                onCancel: () {
                  Navigator.of(context).pop();
                }));
      }),
      rightButtonVisibility: true,
      screenTitle: AppLocalizations.of(context)!.lblTitleWizard7,
      screenDesc: AppLocalizations.of(context)!.lblDescWizard7,
      dialogContent: AppLocalizations.of(context)!.lblContentDialogWizard7,
      currentStep: 7,
      btnNextLabel: AppLocalizations.of(context)!.btnReviewListing,
      onNextPressed: _gridItems.length < 6
          ? null
          : () {
              _reviewAds(context);
            },
      onOkDialog: () => Navigator.of(context).pop(),
      screenContent: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.h,
              mainAxisSpacing: 10.w,
            ),
            itemCount: _gridItems.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return AddPhotoButton(onPressed: () {
                  showImageSelectionOption(
                      context: context,
                      onGalleryPressed: () {
                        // get image from gallery
                        getImageFrom(ImageSource.gallery);
                        // close the options modal
                        Navigator.of(context).pop();
                      },
                      onCameraPressed: () {
                        // get image from camera
                        getImageFrom(ImageSource.camera);
                        // close the options modal
                        Navigator.of(context).pop();
                      });
                });
              } else {
                return ImageCard(
                    image: (_gridItems[index] as ImageCard).image,
                    photoNumber: index,
                    onRemovePressed: () {
                      setState(() {
                        _gridItems.removeAt(index);
                      });
                    });
              }
            },
          ),
        ),
      ),
    );
  }

  void _reviewAds(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            // TODO: modify with the real data
            builder: (context) => const FacilityDetailPage(
                isStudent: false,
                isWizardPage: true,
                facilityPhotos: [
                  "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg",
                  "https://cdn.cosedicasa.com/wp-content/uploads/webp/2022/05/cucina-e-soggiorno-640x320.webp",
                  "https://www.grazia.it/content/uploads/2018/03/come-arredare-monolocale-sfruttando-centimetri-2.jpg"
                ],
                facilityName: "Casa Dolce Casa",
                facilityAddress: "Padova - Via Roma 12",
                facilityPrice: 300,
                facilityHostName: "Mario Rossi",
                hostUrlImage:
                    "https://cdn.create.vista.com/api/media/medium/319362956/stock-photo-man-pointing-showing-copy-space-isolated-on-white-background-casual-handsome-caucasian-young-man?token=",
                facilityServices: [
                  "2 bedrooms",
                  "3 beds",
                  "1 bathroom",
                  "WiFi"
                ])));
  }

  /// Show dialog for android, with options to choose from gallery or camera
  Future _showAndroidModal() {
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
                // Gallery option
                TextButton.icon(
                  onPressed: () {
                    getImageFrom(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  label: Text(AppLocalizations.of(context)!.btnGallery),
                  icon: const Icon(Icons.photo),
                ),
                Divider(
                  color: ColorPalette.ceruleanBlue.withOpacity(0.5),
                  thickness: 1.h,
                ),
                // Camera option
                TextButton.icon(
                  onPressed: () {
                    getImageFrom(ImageSource.camera);
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

  /// Show dialog for iOS, with options to choose from gallery or camera
  Future _showIosModal() async {
    showCupertinoModalPopup(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(AppLocalizations.of(context)!.lblChooseOption),
        actions: [
          // Gallery option
          CupertinoActionSheetAction(
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFrom(ImageSource.gallery);
            },
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
          ),
          // Camera option
          CupertinoActionSheetAction(
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFrom(ImageSource.camera);
            },
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
          ),
        ],
      ),
    );
  }

  // Show dialog based on platform
  void showImageSelectionOption(
      {required BuildContext context,
      required void Function() onGalleryPressed,
      required void Function() onCameraPressed}) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      _showAndroidModal();
    } else {
      _showIosModal();
    }
  }
}

// class _WizardPage7Body extends StatefulWidget {
//   const _WizardPage7Body();

//   @override
//   State<_WizardPage7Body> createState() => _WizardPage7BodyState();
// }

// class _WizardPage7BodyState extends State<_WizardPage7Body> {
//   late File _image;
//   final picker = ImagePicker();
//   late List<Widget> _gridItems;

//   @override
//   void initState() {
//     super.initState();

//     _image = File('');

//     _gridItems = [];

//     _gridItems.add(
//       AddPhotoButton(onPressed: () {
//         showOptionsDialog(
//             context: context,
//             onGalleryPressed: () {
//               // get image from gallery
//               getImageFrom(ImageSource.gallery);
//               // close the options modal
//               Navigator.of(context).pop();
//             },
//             onCameraPressed: () {
//               // get image from camera
//               getImageFrom(ImageSource.camera);
//               // close the options modal
//               Navigator.of(context).pop();
//             });
//       }),
//     );
//   }

//   // Getting image from [ImageSource source]
//   Future<void> getImageFrom(ImageSource source) async {
//     final pickedFile = await picker.pickImage(source: source);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         _gridItems.add(ImageCard(
//           image: _image,
//           photoNumber: _gridItems.length,
//         ));
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10.h,
//             mainAxisSpacing: 10.w,
//           ),
//           itemCount: _gridItems.length,
//           itemBuilder: (context, index) {
//             if (index == 0) {
//               return AddPhotoButton(onPressed: () {
//                 showOptionsDialog(
//                     context: context,
//                     onGalleryPressed: () {
//                       // get image from gallery
//                       getImageFrom(ImageSource.gallery);
//                       // close the options modal
//                       Navigator.of(context).pop();
//                     },
//                     onCameraPressed: () {
//                       // get image from camera
//                       getImageFrom(ImageSource.camera);
//                       // close the options modal
//                       Navigator.of(context).pop();
//                     });
//               });
//             } else {
//               return ImageCard(
//                   image: (_gridItems[index] as ImageCard).image,
//                   photoNumber: index,
//                   onRemovePressed: () {
//                     setState(() {
//                       _gridItems.removeAt(index);
//                     });
//                   });
//             }
//           },
//         ),
//       ),
//     );
//   }

//   /// Show dialog for android, with options to choose from gallery or camera
//   Future _showAndroidModal() {
//     return showModalBottomSheet(
//       useSafeArea: true,
//       context: context,
//       builder: (BuildContext context) {
//         return SizedBox(
//           height: 200.h,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   AppLocalizations.of(context)!.lblChooseOption,
//                   style: Theme.of(context).textTheme.displayMedium,
//                 ),
//                 Divider(
//                   color: ColorPalette.ceruleanBlue.withOpacity(0.8),
//                   thickness: 1.h,
//                 ),
//                 // Gallery option
//                 TextButton.icon(
//                   onPressed: () {
//                     getImageFrom(ImageSource.gallery);
//                     Navigator.of(context).pop();
//                   },
//                   label: Text(AppLocalizations.of(context)!.btnGallery),
//                   icon: const Icon(Icons.photo),
//                 ),
//                 Divider(
//                   color: ColorPalette.ceruleanBlue.withOpacity(0.5),
//                   thickness: 1.h,
//                 ),
//                 // Camera option
//                 TextButton.icon(
//                   onPressed: () {
//                     getImageFrom(ImageSource.camera);
//                     Navigator.of(context).pop();
//                   },
//                   label: Text(AppLocalizations.of(context)!.btnCamera),
//                   icon: const Icon(Icons.camera_alt),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// Show dialog for iOS, with options to choose from gallery or camera
//   Future _showIosModal() async {
//     showCupertinoModalPopup(
//       barrierDismissible: true,
//       context: context,
//       builder: (context) => CupertinoActionSheet(
//         title: Text(AppLocalizations.of(context)!.lblChooseOption),
//         actions: [
//           // Gallery option
//           CupertinoActionSheetAction(
//             onPressed: () {
//               // close the options modal
//               Navigator.of(context).pop();
//               // get image from gallery
//               getImageFrom(ImageSource.gallery);
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.photo,
//                   color: ColorPalette.darkConflowerBlue,
//                 ),
//                 Text(AppLocalizations.of(context)!.btnGallery),
//               ],
//             ),
//           ),
//           // Camera option
//           CupertinoActionSheetAction(
//             onPressed: () {
//               // close the options modal
//               Navigator.of(context).pop();
//               // get image from camera
//               getImageFrom(ImageSource.camera);
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.camera_alt,
//                   color: ColorPalette.darkConflowerBlue,
//                 ),
//                 Text(AppLocalizations.of(context)!.btnCamera),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Show dialog based on platform
//   void showOptionsDialog(
//       {required BuildContext context,
//       required void Function() onGalleryPressed,
//       required void Function() onCameraPressed}) {
//     if (Theme.of(context).platform == TargetPlatform.android) {
//       _showAndroidModal();
//     } else {
//       _showIosModal();
//     }
//   }
// }
