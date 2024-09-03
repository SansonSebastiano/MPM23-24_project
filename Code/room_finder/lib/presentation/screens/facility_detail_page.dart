import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/main.dart';
import 'package:room_finder/model/ad_model.dart';
import 'package:room_finder/presentation/components/account_photo.dart';
import 'package:room_finder/presentation/components/alert_dialogs.dart';
import 'package:room_finder/presentation/components/buttons/rectangle_buttons.dart';
import 'package:room_finder/presentation/components/error_messages.dart';
import 'package:room_finder/presentation/components/photo_carousel.dart';
import 'package:room_finder/presentation/components/renter_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/components/snackbar.dart';
import 'package:room_finder/presentation/screens/chat_new_page.dart';
import 'package:room_finder/presentation/screens/current_renters_page.dart';
import 'package:room_finder/presentation/screens/login_page.dart';
import 'package:room_finder/provider/ad_provider.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:room_finder/util/network_handler.dart';

class FacilityDetailPage extends ConsumerStatefulWidget {
  final bool isLogged;

  final bool isStudent;
  final bool isWizardPage;
  final List<String>? facilityPhotosURL;
  final List<File>? facilityPhotos;
  final String facilityName;
  final Address facilityAddress;
  final int facilityPrice;
  final String facilityHostName;
  final String hostUrlImage;
  final String? hostUid;
  final List<String> facilityServices;
  final int maxRenters;
  final List<Renter> facilityRenters;
  final List<Room> facilityRooms;
  final String? adUid;

  const FacilityDetailPage(
      {super.key,
      required this.isLogged,
      required this.isStudent,
      required this.isWizardPage,
      this.facilityPhotosURL,
      this.facilityPhotos,
      required this.facilityName,
      required this.facilityAddress,
      required this.facilityPrice,
      required this.facilityHostName,
      required this.hostUrlImage,
      required this.facilityServices,
      required this.maxRenters,
      required this.facilityRenters,
      required this.facilityRooms,
      this.hostUid,
      this.adUid});

  @override
  ConsumerState<FacilityDetailPage> createState() => FacilityDetailPageState();
}

class FacilityDetailPageState extends ConsumerState<FacilityDetailPage> {
  late bool isSaved;

  @override
  void initState() {
    super.initState();
    isSaved = false;
  }

  void toggleSave() {
    if (widget.isLogged == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {}
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = ref.watch(networkAwareProvider);

    final servicesText = widget.facilityServices.join(' · ');

    List<String> bedsText = <String>[];
    int i = 0;
    for (var room in widget.facilityRooms) {
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
            items: widget.facilityPhotosURL!
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
                : widget.facilityPhotosURL!
                    .map((url) => Image(image: NetworkImage(url)))
                    .toList(),
            isWizardPage: widget.isWizardPage,
            onDeletePressed: () {
              ref
                  .read(adNotifierProvider.notifier)
                  .deleteAd(adUid: widget.adUid!);
            },
            onEditPressed: () {

            },
          );

    ref.listen(adNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        successfulAddNewAd: () {
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
      );
    });

    Future<void> uploadNewAd() async {
      if (networkStatus == NetworkStatus.off) {
        showErrorSnackBar(
            context, AppLocalizations.of(context)!.lblConnectionErrorDesc);
      } else {
        await ref.read(adNotifierProvider.notifier).addNewAd(
            newAd: AdData(
                hostUid: widget.hostUid!,
                name: widget.facilityName,
                address: widget.facilityAddress,
                rooms: widget.facilityRooms,
                rentersCapacity: widget.maxRenters,
                renters: widget.facilityRenters,
                services: widget.facilityServices,
                monthlyRent: widget.facilityPrice),
            photosPaths: widget.facilityPhotos!);
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
                              facilityName: widget.facilityName,
                              facilityAddress:
                                  "${widget.facilityAddress.city} - ${widget.facilityAddress.street}",
                              facilityPrice: widget.facilityPrice,
                              hostUrlImage: widget.hostUrlImage,
                              facilityHostName: widget.facilityHostName),
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
                                    text:
                                        "- ${widget.facilityRooms[index].name}: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                    children: [
                                      widget.facilityRooms[index].runtimeType ==
                                              Bedroom
                                          ? TextSpan(
                                              text:
                                                  "\n   - ${bedsText.getRange(0, bedsText.length).join('\n   - ')}")
                                          : TextSpan(
                                              text:
                                                  "${widget.facilityRooms[index].quantity}",
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
                              itemCount: widget.facilityRooms.length,
                            ),
                          ),
                          const Divider(
                            color: ColorPalette.blueberry,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppLocalizations.of(context)!.lblCurrentRenters(
                                  widget.facilityRenters.length,
                                  widget.maxRenters),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          widget.isStudent
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      if (widget.isLogged) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CurrentRentersPage()),
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
                                          name: widget
                                              .facilityRenters[index].name,
                                          contractDeadline: widget
                                              .facilityRenters[index]
                                              .contractDeadline,
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height: 10.w,
                                        );
                                      },
                                      itemCount: widget.facilityRenters.length,
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
                                          receiverImageUrl: widget.hostUrlImage,
                                          receiverName: widget.facilityHostName,
                                          facilityName: widget.facilityName,
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
                                  await uploadNewAd();
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
