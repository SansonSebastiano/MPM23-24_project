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
import 'package:room_finder/presentation/screens/login_page.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:room_finder/util/network_handler.dart';

class FacilityDetailPage extends ConsumerStatefulWidget {
  final bool isLogged;

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
      required this.isLogged,
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

    final photoCarousel = widget.isStudent
        ? StudentPhotoCarousel(
            items: widget.facilityPhotos
                .map((url) => Image(image: NetworkImage(url)))
                .toList(),
                isSaved: isSaved,
                onPressed: toggleSave,
                )
        : HostPhotoCarousel(
            items: widget.facilityPhotos
                .map((url) => Image(image: NetworkImage(url)))
                .toList(),
            isWizardPage: widget.isWizardPage,
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
                              facilityName: widget.facilityName,
                              facilityAddress: widget.facilityAddress,
                              facilityPrice: widget.facilityPrice,
                              hostUrlImage: widget.hostUrlImage,
                              facilityHostName: widget.facilityHostName),
                          SizedBox(height: 20.h),
                          const Divider(
                            color: ColorPalette.blueberry,
                          ),
                          _RoomsAndAmenities(
                              facilityServices: widget.facilityServices),
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
                                        return widget.facilityRenters[index];
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
                                // TODO: handle confirm wizard operation
                                onPressed: () => {
                                      // TODO: replace with real data
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FacilityDetailPage(
                                            isLogged: widget.isLogged,
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
    );
  }
}

class _RoomsAndAmenities extends StatelessWidget {
  const _RoomsAndAmenities({
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
