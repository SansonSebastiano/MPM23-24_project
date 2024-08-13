import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/account_photo.dart';
import 'package:room_finder/presentation/components/buttons/rectangle_buttons.dart';
import 'package:room_finder/presentation/components/error_messages.dart';
import 'package:room_finder/presentation/components/photo_carousel.dart';
import 'package:room_finder/presentation/components/renter_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/chat_new_page.dart';
import 'package:room_finder/presentation/screens/current_renters_page.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:room_finder/util/network_handler.dart';

class FacilityDetailPage extends ConsumerWidget {
  final bool isStudent;
  final bool isWizardPage;
  final List<String> facilityPhotos;
  final String facilityName;
  final String facilityAddress;
  final double facilityPrice;
  final String facilityHostName;
  final String hostUrlImage;
  final List<String> facilityServices;

  const FacilityDetailPage({
    super.key,
    required this.isStudent,
    required this.isWizardPage,
    required this.facilityPhotos,
    required this.facilityName,
    required this.facilityAddress,
    required this.facilityPrice,
    required this.facilityHostName,
    required this.hostUrlImage,
    required this.facilityServices,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus = ref.watch(networkAwareProvider);

    final photoCarousel = isStudent 
      ? StudentPhotoCarousel(
        items: facilityPhotos.map((url) => Image(image: NetworkImage(url))).toList()) 
      : HostPhotoCarousel(
        items: facilityPhotos.map((url) => Image(image: NetworkImage(url))).toList(),
        isWizardPage: isWizardPage,);

    final servicesText = facilityServices.join(' · ');

    return Scaffold(
      body: networkStatus == NetworkStatus.off
          ? Center(heightFactor: 6.h, child: NoInternetErrorMessage(context: context))
          : Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView( 
                    padding: EdgeInsets.only(bottom: 120.h), // bottom padding to ensure content doesn't overlap with the button
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        photoCarousel,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded( 
                                    child: Text(
                                      facilityName,
                                      style: TextStyle(
                                        color: ColorPalette.oxfordBlue,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '€${facilityPrice.toStringAsFixed(2)}', // Formats the price to 2 decimal places
                                    style: TextStyle(
                                      color: ColorPalette.oxfordBlue,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    facilityAddress,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "per month",
                                    style: TextStyle(
                                      color: ColorPalette.oxfordBlue,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20.h),
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
                              SizedBox(height: 20.h),
                              const Divider(
                                color: ColorPalette.blueberry,
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                AppLocalizations.of(context)!.lblRoomsAmenities,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                servicesText, 
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(height: 15.h),
                              const Divider(
                                color: ColorPalette.blueberry,
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                AppLocalizations.of(context)!.lblCurrentRenters(2, 3),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              if (isStudent) ...[
                                SizedBox(height: 16.h),
                                InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => const CurrentRentersPage()),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.btnMoreDetails,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorPalette.blueberry,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                              if (!isStudent) ...[
                                SizedBox(height: 20.h),
                                HostFacilityDetailPageRenterBox(
                                  name: 'Francesco Dal Maso',
                                  contractDeadline: DateTime(2025, 1, 1),
                                ),
                                SizedBox(height: 15.h),
                                HostFacilityDetailPageRenterBox(
                                  name: 'Antonio Principe',
                                  contractDeadline: DateTime(2025, 3, 1),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isStudent || isWizardPage) ...[
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      color: ColorPalette.aliceBlue,
                      child: isStudent
                          ? Center(
                              child: RectangleButton(
                                label: AppLocalizations.of(context)!.btnRequestInfo,
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ChatNewPage(
                                      receiverImageUrl: hostUrlImage, 
                                      receiverName: facilityHostName, 
                                      facilityName: facilityName, 
                                      onTap: () => {}
                                    )),
                                )
                              ),
                            )
                          : (isWizardPage
                              ? Center(
                                  child: RectangleButton(
                                    label: AppLocalizations.of(context)!.btnConfirm,
                                    // TODO: handle confirm wizard operation
                                    onPressed: () => {}),
                                )
                              : null),
                    ),
                  )
                ]
              ],
            ),
    );
  }
}
