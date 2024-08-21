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
  final List<HostFacilityDetailPageRenterBox> facilityRenters;

  const FacilityDetailPage(
      {super.key,
      required this.isStudent,
      required this.isWizardPage,
      required this.facilityPhotos,
      required this.facilityName,
      required this.facilityAddress,
      required this.facilityPrice,
      required this.facilityHostName,
      required this.hostUrlImage,
      required this.facilityServices,
      required this.facilityRenters});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus = ref.watch(networkAwareProvider);

    final photoCarousel = isStudent
        ? StudentPhotoCarousel(
            items: facilityPhotos
                .map((url) => Image(image: NetworkImage(url)))
                .toList())
        : HostPhotoCarousel(
            items: facilityPhotos
                .map((url) => Image(image: NetworkImage(url)))
                .toList(),
            isWizardPage: isWizardPage,
          );

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
                              facilityName: facilityName,
                              facilityAddress: facilityAddress,
                              facilityPrice: facilityPrice,
                              hostUrlImage: hostUrlImage,
                              facilityHostName: facilityHostName),
                          SizedBox(height: 20.h),
                          const Divider(
                            color: ColorPalette.blueberry,
                          ),
                          _RoomsAndAmenities(
                              facilityServices: facilityServices),
                          const Divider(
                            color: ColorPalette.blueberry,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .lblCurrentRenters(2, 3),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          isStudent
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CurrentRentersPage()),
                                    ),
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
                                        return facilityRenters[index];
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height: 10.w,
                                        );
                                      },
                                      itemCount: facilityRenters.length,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                isStudent
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        child: RectangleButton(
                            label: AppLocalizations.of(context)!.btnRequestInfo,
                            onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ChatNewPage(
                                          receiverImageUrl: hostUrlImage,
                                          receiverName: facilityHostName,
                                          facilityName: facilityName,
                                          onTap: () => {})),
                                )),
                      )
                    : isWizardPage
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: RectangleButton(
                                label: AppLocalizations.of(context)!.btnConfirm,
                                // TODO: handle confirm wizard operation
                                onPressed: () => {
                                      // TODO: replace with real data
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FacilityDetailPage(
                                            isStudent: false,
                                            isWizardPage: false,
                                            facilityPhotos: const [
                                              "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg",
                                              "https://cdn.cosedicasa.com/wp-content/uploads/webp/2022/05/cucina-e-soggiorno-640x320.webp",
                                              "https://www.grazia.it/content/uploads/2018/03/come-arredare-monolocale-sfruttando-centimetri-2.jpg"
                                            ],
                                            facilityName: "Casa Dolce Casa",
                                            facilityAddress:
                                                "Padova - Via Roma 12",
                                            facilityPrice: 300,
                                            facilityHostName: "Mario Rossi",
                                            hostUrlImage:
                                                "https://cdn.create.vista.com/api/media/medium/319362956/stock-photo-man-pointing-showing-copy-space-isolated-on-white-background-casual-handsome-caucasian-young-man?token=",
                                            facilityServices: const [
                                              "2 bedrooms",
                                              "3 beds",
                                              "1 bathroom",
                                              "WiFi"
                                            ],
                                            facilityRenters: [
                                              HostFacilityDetailPageRenterBox(
                                                name: 'Francesco Dal Maso',
                                                contractDeadline:
                                                    DateTime(2025, 1, 1),
                                              ),
                                              HostFacilityDetailPageRenterBox(
                                                name: 'Antonio Principe',
                                                contractDeadline:
                                                    DateTime(2025, 3, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    }),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
      // : Row(
      //   children: [
      //     Stack(
      //         children: [
      //           SingleChildScrollView(
      //             padding: EdgeInsets.only(
      //                 bottom: 120
      //                     .h), // bottom padding to ensure content doesn't overlap with the button
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 photoCarousel,
      //                 Padding(
      //                   padding: EdgeInsets.symmetric(
      //                       horizontal: 16.w, vertical: 8.h),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       SizedBox(height: 10.h),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Expanded(
      //                             child: Text(
      //                               facilityName,
      //                               style: TextStyle(
      //                                 color: ColorPalette.oxfordBlue,
      //                                 fontSize: 24.sp,
      //                                 fontWeight: FontWeight.bold,
      //                               ),
      //                             ),
      //                           ),
      //                           Text(
      //                             '€${facilityPrice.toStringAsFixed(2)}', // Formats the price to 2 decimal places
      //                             style: TextStyle(
      //                               color: ColorPalette.oxfordBlue,
      //                               fontSize: 20.sp,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Text(
      //                             facilityAddress,
      //                             style: Theme.of(context).textTheme.bodyMedium,
      //                           ),
      //                           Text(
      //                             "per month",
      //                             style: TextStyle(
      //                               color: ColorPalette.oxfordBlue,
      //                               fontSize: 16.sp,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                       SizedBox(height: 20.h),
      //                       Row(
      //                         children: [
      //                           AccountPhoto(
      //                               size: 80.w, imageUrl: hostUrlImage),
      //                           SizedBox(width: 20.w),
      //                           Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Text(
      //                                 AppLocalizations.of(context)!.lblHostName,
      //                                 style: TextStyle(
      //                                   color: ColorPalette.oxfordBlue,
      //                                   fontSize: 18.sp,
      //                                 ),
      //                               ),
      //                               Text(
      //                                 facilityHostName,
      //                                 style: TextStyle(
      //                                   color: ColorPalette.oxfordBlue,
      //                                   fontSize: 18.sp,
      //                                   fontWeight: FontWeight.bold,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ],
      //                       ),
      //                       SizedBox(height: 20.h),
      //                       const Divider(
      //                         color: ColorPalette.blueberry,
      //                       ),
      //                       SizedBox(height: 15.h),
      //                       Text(
      //                         AppLocalizations.of(context)!.lblRoomsAmenities,
      //                         style: Theme.of(context).textTheme.displaySmall,
      //                       ),
      //                       SizedBox(height: 10.h),
      //                       SizedBox(
      //                         width: 100.w,
      //                         height: 100.h,
      //                         child: ListView.separated(
      //                           scrollDirection: Axis.horizontal,
      //                           itemCount: facilityServices.length,
      //                           itemBuilder: (BuildContext context, int index) {
      //                             return Text(facilityServices[index]);
      //                           },
      //                           separatorBuilder:
      //                               (BuildContext context, int index) {
      //                             return const Text(' · ');
      //                           },
      //                         ),
      //                       ),
      //                       // Text(
      //                       //   widget.servicesText,
      //                       //   style: Theme.of(context).textTheme.bodyMedium,
      //                       // ),
      //                       SizedBox(height: 15.h),
      //                       const Divider(
      //                         color: ColorPalette.blueberry,
      //                       ),
      //                       SizedBox(height: 15.h),
      //                       Text(
      //                         AppLocalizations.of(context)!
      //                             .lblCurrentRenters(2, 3),
      //                         style: Theme.of(context).textTheme.displaySmall,
      //                       ),
      //                       if (isStudent) ...[
      //                         SizedBox(height: 16.h),
      //                         InkWell(
      //                           onTap: () => Navigator.of(context).push(
      //                             MaterialPageRoute(
      //                                 builder: (context) =>
      //                                     const CurrentRentersPage()),
      //                           ),
      //                           child: Text(
      //                             AppLocalizations.of(context)!.btnMoreDetails,
      //                             style: const TextStyle(
      //                               fontWeight: FontWeight.bold,
      //                               color: ColorPalette.blueberry,
      //                               decoration: TextDecoration.underline,
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                       if (!isStudent) ...[
      //                         SizedBox(height: 20.h),
      //                         HostFacilityDetailPageRenterBox(
      //                           name: 'Francesco Dal Maso',
      //                           contractDeadline: DateTime(2025, 1, 1),
      //                         ),
      //                         SizedBox(height: 15.h),
      //                         HostFacilityDetailPageRenterBox(
      //                           name: 'Antonio Principe',
      //                           contractDeadline: DateTime(2025, 3, 1),
      //                         ),
      //                       ],
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           if (isStudent || isWizardPage) ...[
      //             Positioned(
      //               left: 0,
      //               right: 0,
      //               bottom: 0,
      //               child: Container(
      //                 padding: EdgeInsets.all(16.w),
      //                 color: ColorPalette.aliceBlue,
      //                 child: isStudent
      //                     ? Center(
      //                         child:
      // RectangleButton(
      //                             label: AppLocalizations.of(context)!
      //                                 .btnRequestInfo,
      //                             onPressed: () => Navigator.of(context).push(
      //                                   MaterialPageRoute(
      //                                       builder: (context) => ChatNewPage(
      //                                           receiverImageUrl: hostUrlImage,
      //                                           receiverName: facilityHostName,
      //                                           facilityName: facilityName,
      //                                           onTap: () => {})),
      //                                 )),
      //                       )
      //                     : (isWizardPage
      //                         ? Center(
      //                             child:
      //                              RectangleButton(
      //                                 label: AppLocalizations.of(context)!
      //                                     .btnConfirm,
      //                                 // TODO: handle confirm wizard operation
      //                                 onPressed: () => {
      //                                       // TODO: replace with real data
      //                                       Navigator.push(
      //                                         context,
      //                                         MaterialPageRoute(
      //                                           builder: (context) =>
      //                                               const FacilityDetailPage(
      //                                                   isStudent: false,
      //                                                   isWizardPage: false,
      //                                                   facilityPhotos: [
      //                                                     "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg",
      //                                                     "https://cdn.cosedicasa.com/wp-content/uploads/webp/2022/05/cucina-e-soggiorno-640x320.webp",
      //                                                     "https://www.grazia.it/content/uploads/2018/03/come-arredare-monolocale-sfruttando-centimetri-2.jpg"
      //                                                   ],
      //                                                   facilityName:
      //                                                       "Casa Dolce Casa",
      //                                                   facilityAddress:
      //                                                       "Padova - Via Roma 12",
      //                                                   facilityPrice: 300,
      //                                                   facilityHostName:
      //                                                       "Mario Rossi",
      //                                                   hostUrlImage:
      //                                                       "https://cdn.create.vista.com/api/media/medium/319362956/stock-photo-man-pointing-showing-copy-space-isolated-on-white-background-casual-handsome-caucasian-young-man?token=",
      //                                                   facilityServices: [
      //                                                     "2 bedrooms",
      //                                                     "3 beds",
      //                                                     "1 bathroom",
      //                                                     "WiFi"
      //                                                   ]),
      //                                         ),
      //                                       ),
      //                                     }),
      //                           )
      //                         : null),
      //               ),
      //             )
      //           ]
      //         ],
      //       ),
      //   ],
      // ),
    );
  }
}

class _RoomsAndAmenities extends StatelessWidget {
  const _RoomsAndAmenities({
    super.key,
    required this.facilityServices,
  });

  final List<String> facilityServices;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            AppLocalizations.of(context)!.lblRoomsAmenities,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 40.w,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Align(
                    alignment: Alignment.center,
                    child: Text(facilityServices[index]));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Align(
                    alignment: Alignment.center, child: Text(' · '));
              },
              itemCount: facilityServices.length),
        ),
      ],
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
  final double facilityPrice;
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
