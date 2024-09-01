import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/model/ad_model.dart';
import 'package:room_finder/model/user_model.dart';
import 'package:room_finder/presentation/components/ads_box.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/error_messages.dart';
import 'package:room_finder/presentation/components/renter_box.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/components/search_bar.dart';
import 'package:room_finder/presentation/screens/facility_detail_page.dart';
import 'package:room_finder/presentation/screens/login_page.dart';
import 'package:room_finder/presentation/screens/wizard_screens/wizard_page1.dart';
import 'package:room_finder/provider/ad_provider.dart';
import 'package:room_finder/util/network_handler.dart';

class StudentHomePage extends StatelessWidget {
  final bool isLogged;
  final UserData studentUser;

  const StudentHomePage(
      {super.key, required this.isLogged, required this.studentUser});

  @override
  Widget build(BuildContext context) {
    return MainTemplateScreen(
      screenLabel: isLogged
          ? AppLocalizations.of(context)!.lblWelcomeUser(studentUser.name!)
          : AppLocalizations.of(context)!.lblWelcomeNotLogged,
      screenContent: _StudentHomePageBody(isLogged: isLogged),
    );
  }
}

class _StudentHomePageBody extends ConsumerStatefulWidget {
  final bool isLogged;

  const _StudentHomePageBody({required this.isLogged});

  @override
  ConsumerState<_StudentHomePageBody> createState() =>
      _StudentHomePageBodyState();
}

class _StudentHomePageBodyState extends ConsumerState<_StudentHomePageBody> {
  late List<bool> isSaved;
  late List<AdsBox> adsList;

  @override
  void initState() {
    super.initState();
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

  void toggleSave(int index) {
    if (widget.isLogged == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {}
    setState(() {
      isSaved[index] = !isSaved[index];
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  isLogged: widget.isLogged,
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
                                    builder: (context) => FacilityDetailPage(
                                      isLogged: widget.isLogged,
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
                      return SizedBox(height: 20.h);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class HostHomePage extends StatelessWidget {
  final UserData hostUser;
  const HostHomePage({super.key, required this.hostUser});

  @override
  Widget build(BuildContext context) {
    return MainTemplateScreen(
      // TODO: screenLabel should be adapted to the host user's name
      screenLabel: AppLocalizations.of(context)!.lblWelcomeUser(hostUser.name!),
      screenContent: _HostHomePageBody(
        hostUser: hostUser,
      ),
    );
  }
}

class _HostHomePageBody extends ConsumerStatefulWidget {
  final UserData hostUser;
  const _HostHomePageBody({required this.hostUser});

  @override
  ConsumerState<_HostHomePageBody> createState() => _HostHomePageBodyState();
}

class _HostHomePageBodyState extends ConsumerState<_HostHomePageBody> {
  bool isConnected = false;
  List<AdData> hostAds = [];
  bool isOnLoad = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var connectivityStatusProvider = ref.watch(networkAwareProvider);
      setState(() {
        isConnected = connectivityStatusProvider == NetworkStatus.on;
      });

      if (isConnected) {
        ref
            .read(adNotifierProvider.notifier)
            .getAdsByHostUid(hostUid: widget.hostUser.uid!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(adNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        multipleFailedReads: () => print("Fail on reading multiple ads"),
        multipleSuccessfulReads: (adsData) {
          hostAds = adsData;

          setState(() {
            isOnLoad = false;
          });
        },
      );
    });

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

          isOnLoad 
          ? const Expanded(child: Center(child: CircularProgressIndicator(),)) 
          : !isConnected
              ? Expanded(
                  child: Center(
                    child: NoInternetErrorMessage(context: context),
                  ),
                )
              : hostAds.isEmpty 
              ? Expanded(child: Center(child: NoDataErrorMessage(context: context,),))
              : Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(20.w),
                    itemCount: hostAds.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AdsBox(
                          imageUrl:
                              hostAds[index].photosURLs!.first,
                          city: hostAds[index].address.city,
                          street: hostAds[index].address.street,
                          price: hostAds[index].monthlyRent,
                          onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FacilityDetailPage(
                                      isLogged: true,
                                      isStudent: false,
                                      isWizardPage: false,
                                      facilityPhotos: hostAds[index].photosURLs!,
                                      facilityName: hostAds[index].name,
                                      facilityAddress: "${hostAds[index].address.city} - ${hostAds[index].address.street}",
                                      facilityPrice: hostAds[index].monthlyRent,
                                      facilityHostName: widget.hostUser.name!,
                                      hostUrlImage: widget.hostUser.photoUrl!,
                                      facilityServices: hostAds[index].services,
                                      facilityRenters: hostAds[index].renters,
                                      facilityRooms: hostAds[index].rooms,
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
