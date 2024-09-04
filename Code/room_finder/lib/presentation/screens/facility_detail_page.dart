import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/main.dart';
import 'package:room_finder/model/ad_model.dart';
import 'package:room_finder/model/user_model.dart';
import 'package:room_finder/presentation/components/account_photo.dart';
import 'package:room_finder/presentation/components/buttons/rectangle_buttons.dart';
import 'package:room_finder/presentation/components/error_messages.dart';
import 'package:room_finder/presentation/components/photo_carousel.dart';
import 'package:room_finder/presentation/components/renter_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/components/snackbar.dart';
import 'package:room_finder/presentation/screens/chat_new_page.dart';
import 'package:room_finder/presentation/screens/current_renters_page.dart';
import 'package:room_finder/presentation/screens/login_page.dart';
import 'package:room_finder/presentation/screens/wizard_screens/wizard_page1.dart';
import 'package:room_finder/provider/ad_provider.dart';
import 'package:room_finder/provider/user_provider.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:room_finder/util/network_handler.dart';

class FacilityDetailPage extends ConsumerStatefulWidget {
  final bool isLogged;

  final bool isStudent;
  final bool isWizardPage;
  final AdData ad;
  final List<File>? facilityPhotos;
  final UserData? host;
  final String? adUid;
  final String? studentUid;
  final bool isEditingMode;

  const FacilityDetailPage(
      {super.key,
      required this.isLogged,
      required this.isStudent,
      required this.isWizardPage,
      required this.ad,
      this.facilityPhotos,
      this.host,
      this.adUid,
      this.studentUid,
      required this.isEditingMode});

  @override
  ConsumerState<FacilityDetailPage> createState() => FacilityDetailPageState();
}

class FacilityDetailPageState extends ConsumerState<FacilityDetailPage> {
  bool isSaved = false;
  bool oneTime = false;

  @override
  void initState() {
    super.initState();
  }

  void toggleSave() async {
    if (widget.isLogged == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      if (isSaved) {
        await ref
            .read(userNotifierProvider.notifier)
            .removeSavedAd(adUid: widget.adUid!, userUid: widget.studentUid!);
      } else {
        await ref
            .read(userNotifierProvider.notifier)
            .saveAd(adUid: widget.adUid!, userUid: widget.studentUid!);
      }
    }
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userNotifierProvider, (previous, next) {
      next.maybeWhen(
          orElse: () => null,
          successfulSavedAdRead: (isAdSavedValue, index) {
            setState(() {
              isSaved = isAdSavedValue;
            });
          });
    });

    if (widget.isLogged && widget.isStudent) {
      Future.delayed(const Duration(microseconds: 0), () async {
        if (oneTime == false) {
          await ref.read(userNotifierProvider.notifier).isAdSaved(
              adUid: widget.adUid!, userUid: widget.studentUid!, index: 0);
          oneTime = true;
        }
      });
    }

    final networkStatus = ref.watch(networkAwareProvider);

    final servicesText = widget.ad.services.join(' · ');

    List<String> bedsText = <String>[];
    int i = 0;
    for (var room in widget.ad.rooms) {
      if (room.runtimeType == Bedroom) {
        for (var beds in (room as Bedroom).numBeds) {
          bedsText.add(
              "${AppLocalizations.of(context)!.lblBedroom(i + 1)}: ${AppLocalizations.of(context)!.lblBed(beds)}");
          i++;
        }
      }
    }

    final photoCarousel = widget.isStudent
        ? StudentPhotoCarousel(
            items: widget.ad.photosURLs!
                .map((url) => Image(image: NetworkImage(url)))
                .toList(),
            isSaved: isSaved,
            onPressed: toggleSave,
          )
        : HostPhotoCarousel(
            items: widget.isWizardPage
                ? widget.facilityPhotos!
                    .map((file) => Image.file(file))
                    .toList()
                : widget.ad.photosURLs!
                    .map((url) => Image(image: NetworkImage(url)))
                    .toList(),
            isWizardPage: widget.isWizardPage,
            onDeletePressed: () {
              ref
                  .read(adNotifierProvider.notifier)
                  .deleteAd(adUid: widget.adUid!);
            },
            onEditPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WizardPage1(
                            hostUser: widget.host!,
                            isEditingMode: true,
                            adToEdit: widget.ad,
                          )));
            },
          );

    ref.listen(adNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        successfulAddNewAd: () {
          // FIXME: too slow
          showSuccessSnackBar(
              context, AppLocalizations.of(context)!.lblSuccessfulAdUpload);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        },
        failedAddNewAd: () {
          // TODO:
        },
        successfulDeleteAd: () {
          showSuccessSnackBar(
              context, AppLocalizations.of(context)!.lblSuccessfulAdDeleted);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        },
        failedDeleteAd: () {
          // TODO:
        },
        successfulUpdateAd: () {
          showSuccessSnackBar(
              context, AppLocalizations.of(context)!.lblSuccessfulAdUpdated);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        },
        failedUpdateAd: () {
          // TODO: 
        },
      );
    });

    Future<void> uploadNewAd() async {
      if (networkStatus == NetworkStatus.off) {
        showErrorSnackBar(
            context, AppLocalizations.of(context)!.lblConnectionErrorDesc);
      } else {
        await ref.read(adNotifierProvider.notifier).addNewAd(
            newAd: AdData(
                hostUid: widget.host!.uid!,
                hostName: widget.host!.name!,
                hostPhotoURL: widget.host!.photoUrl!,
                name: widget.ad.name,
                address: widget.ad.address,
                rooms: widget.ad.rooms,
                rentersCapacity: widget.ad.rentersCapacity,
                renters: widget.ad.renters,
                services: widget.ad.services,
                monthlyRent: widget.ad.monthlyRent),
            photosPaths: widget.facilityPhotos!);
      }
    }

    Future<void> updateAd() async {
      if (networkStatus == NetworkStatus.off) {
        showErrorSnackBar(
            context, AppLocalizations.of(context)!.lblConnectionErrorDesc);
      } else {
        await ref.read(adNotifierProvider.notifier).updateAd(
            updatedAd: AdData(
              uid: widget.ad.uid,
              hostUid: widget.host!.uid!,
              hostName: widget.host!.name!,
              hostPhotoURL: widget.host!.photoUrl!,
              name: widget.ad.name,
              address: widget.ad.address,
              rooms: widget.ad.rooms,
              rentersCapacity: widget.ad.rentersCapacity,
              renters: widget.ad.renters,
              services: widget.ad.services,
              monthlyRent: widget.ad.monthlyRent),
            newPhotosPaths: widget.facilityPhotos!);
      }
    }

    return Scaffold(
      body: networkStatus == NetworkStatus.off
          ? Center(
              heightFactor: 6.h,
              child: NoInternetErrorMessage(context: context))
          : Column(
              children: [
                photoCarousel,
                Expanded(
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    children: [
                      Column(
                        children: [
                          _MainFacilityInfos(
                              facilityName: widget.ad.name,
                              facilityAddress:
                                  "${widget.ad.address.city} - ${widget.ad.address.street}",
                              facilityPrice: widget.ad.monthlyRent,
                              hostUrlImage: widget.ad.hostPhotoURL,
                              facilityHostName: widget.ad.hostName),
                          SizedBox(height: 20.h),
                          const Divider(
                            color: ColorPalette.blueberry,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppLocalizations.of(context)!.lblAmenities,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                servicesText,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          const Divider(
                            color: ColorPalette.blueberry,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppLocalizations.of(context)!.lblRooms,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 100.h,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext context, int index) {
                                return RichText(
                                  text: TextSpan(
                                    // TODO: check if some rooms are 0
                                    text: "- ${widget.ad.rooms[index].name}: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                    children: [
                                      widget.ad.rooms[index].runtimeType ==
                                              Bedroom
                                          ? TextSpan(
                                              text:
                                                  "\n   - ${bedsText.getRange(0, bedsText.length).join('\n   - ')}")
                                          : TextSpan(
                                              text:
                                                  "${widget.ad.rooms[index].quantity}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium)
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 10.w,
                                );
                              },
                              itemCount: widget.ad.rooms.length,
                            ),
                          ),
                          const Divider(
                            color: ColorPalette.blueberry,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppLocalizations.of(context)!.lblCurrentRenters(
                                  widget.ad.renters.length,
                                  widget.ad.rentersCapacity),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          widget.isStudent && widget.ad.renters.isNotEmpty
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      if (widget.isLogged) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CurrentRentersPage(
                                                    facilityName:
                                                        widget.ad.name,
                                                    facilityAddress:
                                                        widget.ad.address,
                                                    facilityMaximumRentersCapacity:
                                                        widget
                                                            .ad.rentersCapacity,
                                                    facilityRenters:
                                                        widget.ad.renters,
                                                  )),
                                        );
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()),
                                        );
                                      }
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .btnMoreDetails,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                              fontSize: 16.sp,
                                              color: ColorPalette.blueberry,
                                              decoration:
                                                  TextDecoration.underline,
                                            )),
                                  ),
                                )
                              : SizedBox(
                                  height: 200.h,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return HostFacilityDetailPageRenterBox(
                                          name: widget.ad.renters[index].name,
                                          contractDeadline: widget.ad
                                              .renters[index].contractDeadline,
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height: 10.w,
                                        );
                                      },
                                      itemCount: widget.ad.renters.length,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                widget.isStudent
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        child: RectangleButton(
                            label: AppLocalizations.of(context)!.btnRequestInfo,
                            onPressed: () {
                              if (widget.isLogged) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ChatNewPage(
                                          receiverImageUrl:
                                              widget.ad.hostPhotoURL,
                                          receiverName: widget.ad.hostName,
                                          facilityName: widget.ad.name,
                                          onTap: () => {})),
                                );
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              }
                            }),
                      )
                    : widget.isWizardPage
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: RectangleButton(
                                label: AppLocalizations.of(context)!.btnConfirm,
                                onPressed: () async {
                                  widget.isEditingMode 
                                  ? await updateAd()
                                  : await uploadNewAd();
                                }),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
    );
  }
}

class _MainFacilityInfos extends StatelessWidget {
  const _MainFacilityInfos({
    required this.facilityName,
    required this.facilityAddress,
    required this.facilityPrice,
    required this.hostUrlImage,
    required this.facilityHostName,
  });

  final String facilityName;
  final String facilityAddress;
  final int facilityPrice;
  final String hostUrlImage;
  final String facilityHostName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: facilityName,
                style: Theme.of(context).textTheme.displaySmall,
                children: [
                  TextSpan(
                    text: '\n$facilityAddress',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text:
                    '€${facilityPrice.toStringAsFixed(2)}', // Formats the price to 2 decimal places
                style: Theme.of(context).textTheme.displaySmall,
                children: [
                  TextSpan(
                    text: '\n${AppLocalizations.of(context)!.lblPricePerMonth}',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            AccountPhoto(size: 80.w, imageUrl: hostUrlImage),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.lblHostName,
                  style: TextStyle(
                    color: ColorPalette.oxfordBlue,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  facilityHostName,
                  style: TextStyle(
                    color: ColorPalette.oxfordBlue,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
