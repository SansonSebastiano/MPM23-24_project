import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/ads_box.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/error_messages.dart';
import 'package:room_finder/presentation/components/renter_box.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/facility_detail_page.dart';
import 'package:room_finder/util/network_handler.dart';

class SavedAdsPage extends ConsumerWidget {
  const SavedAdsPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus = ref.watch(networkAwareProvider);

    return MainTemplateScreen(
      screenLabel: AppLocalizations.of(context)!.lblSavedAds, 
      screenContent: networkStatus == NetworkStatus.off
          ? Center(heightFactor: 6.h, child: NoInternetErrorMessage(context: context)) 
          : const _SavedAdsPageBody(),
    );
  }
}
class _SavedAdsPageBody extends ConsumerStatefulWidget {
  const _SavedAdsPageBody();

  @override
  ConsumerState<_SavedAdsPageBody> createState() =>
      _StudentHomePageBodyState();
}

class _StudentHomePageBodyState extends ConsumerState<_SavedAdsPageBody> {
  late List<bool> isSaved;
  late List<AdsBox> adsList;

  @override
  void initState() {
    super.initState();
    isSaved = List.generate(4, (index) => true);
    adsList = List<AdsBox>.generate(
        4,
        (index) => 
         AdsBox(
            imageUrl:
                "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg",
            city: "Padova",
            street: "Via Roma 12",
            price: 300,
            bookmarkButton: BookmarkButton(
              size: 50.0,
              isSaved: isSaved[index],
              onPressed: () => toggleSave(index),
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
                            contractDeadline: DateTime(2025, 1, 1),
                          ),
                          HostFacilityDetailPageRenterBox(
                            name: 'Antonio Principe',
                            contractDeadline: DateTime(2025, 3, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                }));
  }

  void toggleSave(int index) {
    setState(() {
      isSaved[index] = !isSaved[index];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(AppLocalizations.of(context)!.lblSavedAdsDesc),  
          ), 
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(15.w), 
              itemCount: adsList.length, 
              itemBuilder: (BuildContext context, int index) {
                return AdsBox(
                  imageUrl: "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg", 
                  city: "Padova", 
                  street: "Via Roma 12", 
                  price: 300, 
                  bookmarkButton: BookmarkButton(
                    size: 50.0,
                    isSaved: isSaved[index],
                    onPressed: () => toggleSave(index),
                  ),
                  onPressed: () => {
                    // TODO: replace with real data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FacilityDetailPage(
                                isStudent: true,
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
                                      contractDeadline: DateTime(2025, 1, 1),
                                    ),
                                    HostFacilityDetailPageRenterBox(
                                      name: 'Antonio Principe',
                                      contractDeadline: DateTime(2025, 3, 1),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  } 
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20.h); // Add padding between items
              },
            ),
          )
        ]
      )
    );
  }
}
