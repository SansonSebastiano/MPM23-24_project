import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/model/ad_model.dart';
import 'package:room_finder/presentation/components/ads_box.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/error_messages.dart';
import 'package:room_finder/presentation/components/filter_panel.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:room_finder/presentation/components/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/facility_detail_page.dart';
import 'package:room_finder/presentation/screens/login_page.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:room_finder/util/network_handler.dart';

class SearchResultsPage extends ConsumerStatefulWidget {
  final bool isLogged;

  const SearchResultsPage({super.key, required this.isLogged});

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
  late List<bool> isSaved;
  late List<AdsBox> adsList;

  late RangeValues _currentRangeValues;
  late Map<String, bool> _amenitiesSwitches;
  late Map<String, int> _selectedRoomIndex;

  @override
  void initState() {
    super.initState();
    // TODO: the end should be the max value from the backend
    _currentRangeValues = const RangeValues(0, 1000);
    _amenitiesSwitches = {};
    _selectedRoomIndex = {};

    isSaved = List.generate(4, (index) => false);
    adsList = List<AdsBox>.generate(
        4,
        (index) => AdsBox(
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
                        isLogged: widget.isLogged,
                        isStudent: true,
                        isWizardPage: false,
                        facilityPhotosURL: const [
                          "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg",
                          "https://cdn.cosedicasa.com/wp-content/uploads/webp/2022/05/cucina-e-soggiorno-640x320.webp",
                          "https://www.grazia.it/content/uploads/2018/03/come-arredare-monolocale-sfruttando-centimetri-2.jpg"
                        ],
                        facilityName: "Casa Dolce Casa",
                        facilityAddress: Address(street: 'street', city: 'city'),
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
                        maxRenters: 10,
                        facilityRenters: [
                          // HostFacilityDetailPageRenterBox(
                          //   name: 'Francesco Dal Maso',
                          //   contractDeadline: DateTime(2025, 1, 1),
                          // ),
                          // HostFacilityDetailPageRenterBox(
                          //   name: 'Antonio Principe',
                          //   contractDeadline: DateTime(2025, 3, 1),
                          // ),
                        ],
                        facilityRooms: [],
                      ),
                    ),
                  ),
                }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _amenitiesSwitches = {
      AppLocalizations.of(context)!.lblWiFi: false,
      AppLocalizations.of(context)!.lblDishwasher: false,
      AppLocalizations.of(context)!.lblWashingMachine: false,
      AppLocalizations.of(context)!.lblDedicatedParking: false,
      AppLocalizations.of(context)!.lblAirConditioning: false,
    };

    _selectedRoomIndex = {
      AppLocalizations.of(context)!.lblBedrooms: 0,
      AppLocalizations.of(context)!.lblBeds: 0,
      AppLocalizations.of(context)!.lblBathrooms: 0,
      AppLocalizations.of(context)!.lblRoommates: 0
    };
  }

  void toggleSave(int index) {
    if (widget.isLogged == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {}
    setState(() {
      isSaved[index] = !isSaved[index];
    });
  }

  void _showSearchFilterPanel() {
    _showFilterPanel();
    // showModalPanel(
    //     context: context,
    //     panel: SearchFilterPanel(
    //       context: context,
    //       panelTitle: AppLocalizations.of(context)!.lblFilters,
    //       buttonLabel: AppLocalizations.of(context)!.btnApplyFilters,
    //       // TODO: Implement the onConfirm function
    //       onConfirmPressed: () {},
    //       onClosedPressed: () => Navigator.pop(context),
    //       currentRangeValues: _currentRangeValues,
    //       onPriceChanged: (values) {
    //         setState(() {
    //           _currentRangeValues = values;
    //         });
    //       },
    //     ));
  }

  Future _showFilterPanel() {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: ColorPalette.lavenderBlue,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return SearchFilterPanel(
            context: context,
            panelTitle: AppLocalizations.of(context)!.lblFilters,
            buttonLabel: AppLocalizations.of(context)!.btnApplyFilters,
            // TODO: Implement the onConfirm function
            onConfirmPressed: () {},
            onClosedPressed: () => Navigator.pop(context),
            currentRangeValues: _currentRangeValues,
            onPriceChanged: (values) {
              setModalState(() {
                _currentRangeValues = values;
              });
              print("price: $_currentRangeValues");
            },
            amenitiesSwitches: _amenitiesSwitches,
            onServiceChanged: (key, value) {
              setModalState(() {
                _amenitiesSwitches[key] = value;
              });
              print("$key: ${_amenitiesSwitches[key]}");
            },
            selectedRoomIndex: _selectedRoomIndex,
            onRoomIndexSelected: (key, value, entry) {
              setModalState(() {
                _selectedRoomIndex[key] = value ? entry : 0;
              });
              print("$key: ${_selectedRoomIndex[key]}");
            },
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = ref.watch(networkAwareProvider);
    // TODO: Implement the logic to check if filters are applied
    bool areFiltersApplied = true;

    return SecondaryTemplateScreen(
        leftHeaderWidget:
            DarkBackButton(onPressed: () => Navigator.pop(context)),
        centerHeaderWidget: CustomSearchBar(
          hintText: "Padova",
          isLogged: widget.isLogged,
        ),
        rightHeaderWidget:
            FilterButton(onPressed: () => _showSearchFilterPanel()),
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
                        : const SizedBox.shrink(),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(20.w),
                        itemCount: adsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AdsBox(
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
                                        builder: (context) =>
                                            FacilityDetailPage(
                                          isLogged: widget.isLogged,
                                          isStudent: true,
                                          isWizardPage: false,
                                          facilityPhotosURL: const [
                                            "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg",
                                            "https://cdn.cosedicasa.com/wp-content/uploads/webp/2022/05/cucina-e-soggiorno-640x320.webp",
                                            "https://www.grazia.it/content/uploads/2018/03/come-arredare-monolocale-sfruttando-centimetri-2.jpg"
                                          ],
                                          facilityName: "Casa Dolce Casa",
                                          facilityAddress: Address(street: 'street', city: 'city'),
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
                                          maxRenters: 10,
                                          facilityRenters: [
                                            // HostFacilityDetailPageRenterBox(
                                            //   name: 'Francesco Dal Maso',
                                            //   contractDeadline:
                                            //       DateTime(2025, 1, 1),
                                            // ),
                                            // HostFacilityDetailPageRenterBox(
                                            //   name: 'Antonio Principe',
                                            //   contractDeadline:
                                            //       DateTime(2025, 3, 1),
                                            // ),
                                          ],
                                          facilityRooms: [],
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
              ));
  }
}
