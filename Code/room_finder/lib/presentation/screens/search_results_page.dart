import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/ads_box.dart';
import 'package:room_finder/presentation/components/base_panel.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/error_messages.dart';
import 'package:room_finder/presentation/components/filter_panel.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:room_finder/presentation/components/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/facility_detail_page.dart';
import 'package:room_finder/util/network_handler.dart';

class SearchResultsPage extends ConsumerStatefulWidget {
  const SearchResultsPage({super.key});

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
  void _showSearchFilterPanel(BuildContext context) {
    showModalPanel(
        context: context,
        panel: SearchFilterPanel(
            context: context,
            panelTitle: AppLocalizations.of(context)!.lblFilters,
            buttonLabel: AppLocalizations.of(context)!.btnApplyFilters,
            // TODO: Implement the onConfirm function
            onConfirmPressed: () {},
            onClosedPressed: () => Navigator.pop(context)));
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = ref.watch(networkAwareProvider);
    // TODO: Implement the logic to check if filters are applied
    bool areFiltersApplied = true;

    return SecondaryTemplateScreen(
        leftHeaderWidget:
            DarkBackButton(onPressed: () => Navigator.pop(context)),
        centerHeaderWidget: const CustomSearchBar(hintText: "Padova"),
        rightHeaderWidget:
            FilterButton(onPressed: () => _showSearchFilterPanel(context)),
        rightHeaderWidgetVisibility: true,
        content: networkStatus == NetworkStatus.off
            ? Center(
                heightFactor: 8.h,
                child: NoInternetErrorMessage(context: context))
            : Expanded(
                child: Column(
                  children: [
                    areFiltersApplied
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: OutlinedButton.icon(
                              onPressed: () {
                                print("remove filters pressed");
                                // TODO: implement areFiltersApplied logic
                                // setState(() {
                                //   areFiltersApplied = false;
                                // });
                              },
                              label: Text(AppLocalizations.of(context)!
                                  .btnRemoveFilters),
                              icon: const Icon(Icons.clear_rounded),
                              style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).colorScheme.error,
                                  side: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error)),
                            ),
                          )
                        : SizedBox.shrink(),
                    Expanded(
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
                              bookmarkButton: const BookmarkButton(
                                size: 50.0,
                                isSaved: false,
                              ),
                              onPressed: () => {
                                    // TODO: replace with real data
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const FacilityDetailPage(
                                                isStudent: true,
                                                isWizardPage: false,
                                                facilityPhotos: [
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
                                                facilityServices: [
                                                  "2 bedrooms",
                                                  "3 beds",
                                                  "1 bathroom",
                                                  "WiFi"
                                                ]),
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
              ));
  }
}

class SearchResultsPageBody extends StatelessWidget {
  const SearchResultsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              bookmarkButton: const BookmarkButton(
                size: 50.0,
                isSaved: false,
              ),
              onPressed: () => {
                    // TODO: replace with real data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FacilityDetailPage(
                            isStudent: true,
                            isWizardPage: false,
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
                            ]),
                      ),
                    ),
                  });
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 20.h); // Add padding between items
        },
      ),
    );
  }
}
