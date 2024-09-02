import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/data/user_data.dart';
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
import 'package:room_finder/provider/user_provider.dart';
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
      screenContent: _StudentHomePageBody(isLogged: isLogged, studentUser: studentUser),
    );
  }
}

class _StudentHomePageBody extends ConsumerStatefulWidget {
  final bool isLogged;
  final UserData studentUser;

  const _StudentHomePageBody({required this.isLogged, required this.studentUser});

  @override
  ConsumerState<_StudentHomePageBody> createState() =>
      _StudentHomePageBodyState();
}

class _StudentHomePageBodyState extends ConsumerState<_StudentHomePageBody> {
  bool isConnected = false;
  List<AdData> randomCityAds = [];
  bool isOnLoad = true;
  late List<bool> areAdsSaved;
  late List<bool> oneTime;

  @override
  void initState() {
    super.initState();
    areAdsSaved = <bool>[];
    oneTime = <bool>[];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var connectivityStatusProvider = ref.watch(networkAwareProvider);
      setState(() {
        isConnected = connectivityStatusProvider == NetworkStatus.on;
      });

      ref.read(adNotifierProvider.notifier).getAdsForRandomCity();
    });
  }

  void toggleSave(int index, String adUid, String userUid) async {
    if (widget.isLogged == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      if(areAdsSaved[index]) {
        await ref.read(userNotifierProvider.notifier).removeSavedAd(
          adUid: adUid, 
          userUid: userUid
        );
      } else {
        await ref.read(userNotifierProvider.notifier).saveAd(
          adUid: adUid, 
          userUid: userUid
        );
      }
    }

    setState(() {
      areAdsSaved[index] = !areAdsSaved[index];
    });
  } 

  @override
  Widget build(BuildContext context) {
    ref.listen(adNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        multipleFailedReads: () => print("Fail on reading multiple ads"),
        multipleSuccessfulReads: (adsData) {
          randomCityAds = adsData;

          // initializing isSavedAd, oneTime lists
          for (var element in randomCityAds) {
            areAdsSaved.add(false);
            oneTime.add(false);
          }

          setState(() {
            isOnLoad = false;
          });
        },
      );
    });

    ref.listen(userNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        successfulSavedAdRead : (isAdSaved, index) {
          setState(() {
            //bool isFirstAdSaved = areAdsSaved[0];

            areAdsSaved[index] = isAdSaved;

            //if(oneTime[0] && index == 0) {
            //  areAdsSaved[index] = isFirstAdSaved;
            //}
          });
        }
      );
    });

    if(ref.read(networkAwareProvider) == NetworkStatus.off){
      isOnLoad = false;
    }

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

          isOnLoad 
          ? const Expanded(child: Center(child: CircularProgressIndicator(),)) 
          : ref.read(networkAwareProvider) == NetworkStatus.off
              ? Expanded(
                  child: Center(
                    child: NoInternetErrorMessage(context: context),
                  ),
                )
              : randomCityAds.isEmpty 
              ? Expanded(child: Center(child: NoDataErrorMessage(context: context,),))
              : Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: randomCityAds.length,
                  itemBuilder: (BuildContext context, int index) {
                    Future.delayed(const Duration(microseconds: 0), () async {
                      if(oneTime[index] == false) {
                        await ref.read(userNotifierProvider.notifier).isAdSaved(
                          adUid: randomCityAds[index].uid!,
                          userUid: widget.studentUser.uid!,
                          index: index
                        );
                        oneTime[index] = true;
                      }
                    });

                    return AdsBox(
                        imageUrl:
                            randomCityAds[index].photosURLs!.first,
                        city: randomCityAds[index].address.city,
                        street: randomCityAds[index].address.street,
                        price: randomCityAds[index].monthlyRent,
                        bookmarkButton: BookmarkButton(
                          size: 50.0,
                          isSaved: areAdsSaved[index], 
                          onPressed: () => toggleSave(index, randomCityAds[index].uid!, widget.studentUser.uid!),
                        ),
                        onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FacilityDetailPage(
                                    isLogged: widget.isLogged,
                                    isStudent: true,
                                    isWizardPage: false,
                                    facilityPhotos: randomCityAds[index].photosURLs!,
                                    facilityName: randomCityAds[index].name,
                                    facilityAddress: "${randomCityAds[index].address.city} - ${randomCityAds[index].address.street}",
                                    facilityPrice: randomCityAds[index].monthlyRent,
                                    facilityHostName: "DA IMPLEMENTARE", // TODO
                                    hostUrlImage: "DA IMPLEMENTARE", // TODO
                                    facilityServices: randomCityAds[index].services,
                                    facilityRenters: randomCityAds[index].renters,
                                    facilityRooms: randomCityAds[index].rooms,
                                    adUid: randomCityAds[index].uid,
                                    studentUid: widget.studentUser.uid,
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
