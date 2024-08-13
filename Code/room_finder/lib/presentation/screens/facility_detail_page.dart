import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/account_photo.dart';
import 'package:room_finder/presentation/components/buttons/rectangle_buttons.dart';
import 'package:room_finder/presentation/components/photo_carousel.dart';
import 'package:room_finder/presentation/components/renter_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/current_renters_page.dart';
import 'package:room_finder/style/color_palette.dart';

// TODO: handle lists of renters and facility photos
class FacilityDetailPage extends StatelessWidget {
  final bool isStudent;
  final bool isWizardPage;
  final String facilityName;
  final String facilityAddress;
  final double facilityPrice;
  final String facilityHostName;
  final String hostUrlImage;
  final String facilityServices;

  const FacilityDetailPage({
    super.key,
    required this.isStudent,
    required this.isWizardPage,
    required this.facilityName,
    required this.facilityAddress,
    required this.facilityPrice,
    required this.facilityHostName,
    required this.hostUrlImage,
    required this.facilityServices,
  });

  @override
  Widget build(BuildContext context) {
    const photoCarousel = StudentPhotoCarousel(
      items: [
        Image(image: NetworkImage("https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg")),
        Image(image: NetworkImage("https://cdn.cosedicasa.com/wp-content/uploads/webp/2022/05/cucina-e-soggiorno-640x320.webp")),
        Image(image: NetworkImage("https://www.grazia.it/content/uploads/2018/03/come-arredare-monolocale-sfruttando-centimetri-2.jpg")),
      ],
    );

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView( 
              padding: EdgeInsets.only(bottom: 80.h), // bottom padding to ensure content doesn't overlap with the button
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  photoCarousel,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              style: Theme.of(context).textTheme.bodyLarge,
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
                          facilityServices,
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
          if(isStudent || isWizardPage) ...[
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
                          // TODO: prepare a blank chat page with the facility info (ideally ready to send messages)
                          onPressed: () => {}),
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
