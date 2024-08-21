import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/ads_box.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/error_messages.dart';
import 'package:room_finder/presentation/components/renter_box.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/components/search_bar.dart';
import 'package:room_finder/presentation/screens/facility_detail_page.dart';
import 'package:room_finder/presentation/screens/wizard_screens/wizard_page1.dart';
import 'package:room_finder/util/network_handler.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTemplateScreen(
      // TODO: screenLabel should be adapted to the user's name if logged in or to the default message if not logged in
      screenLabel: AppLocalizations.of(context)!.lblWelcomeUser("<Name>"),
      screenContent: const _StudentHomePageBody(),
    );
  }
}

class _StudentHomePageBody extends ConsumerWidget {
  const _StudentHomePageBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var connectivityStatusProvider = ref.watch(networkAwareProvider);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context)!.lblFindRoom),
                ),
                SizedBox(height: 30.h),
                CustomSearchBar(
                  hintText: AppLocalizations.of(context)!.lblEnterCity,
                ),
                SizedBox(height: 60.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.lblExploreSolutions,
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
          connectivityStatusProvider == NetworkStatus.off
              ? Expanded(
                  child: Center(
                    child: NoInternetErrorMessage(
                      context: context,
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return AdsBox(
                          imageUrl:
                              "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg",
                          city: "Padova",
                          street: "Via Roma 12",
                          price: 300,
                          bookmarkButton: const BookmarkButton(
                            size: 50.0,
                            isSaved: false,
                          ),
                          onPressed: () => {
                                // TODO: replace with real data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FacilityDetailPage(
                                      isStudent: true,
                                      isWizardPage: false,
                                      facilityPhotos: const [
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
                                      facilityServices: const [
                                        "2 bedrooms",
                                        "3 beds",
                                        "1 bathroom",
                                        "WiFi",
                                        "Dedicated parking",
                                        "Air condition"
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
                              });
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                          height: 20.h); // Add padding between items
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class HostHomePage extends StatelessWidget {
  const HostHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTemplateScreen(
      // TODO: screenLabel should be adapted to the host user's name
      screenLabel: AppLocalizations.of(context)!.lblWelcomeUser("<Name>"),
      screenContent: const _HostHomePageBody(),
    );
  }
}

class _HostHomePageBody extends ConsumerWidget {
  const _HostHomePageBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var connectivityStatusProvider = ref.watch(networkAwareProvider);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.lblCreateAds),
                      AddRemoveButton(
                        isAddButton: true,
                        size: 40.w,
                        onPressed: () {
                          // TODO: Replace with real data
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const WizardPage1();
                          }));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          connectivityStatusProvider == NetworkStatus.off
              ? Expanded(
                  child: Center(
                    child: NoInternetErrorMessage(context: context),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(20.w),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return AdsBox(
                          imageUrl:
                              "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg",
                          city: "Padova",
                          street: "Via Roma 12",
                          price: 300,
                          onPressed: () => {
                                // TODO: replace with real data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FacilityDetailPage(
                                      isStudent: false,
                                      isWizardPage: false,
                                      facilityPhotos: const [
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
                              });
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                          height: 20.h); // Add padding between items
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
