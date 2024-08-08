import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/ads_box.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/components/search_bar.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentTemplateScreen(
      // TODO: screenLabel should be adapted to the user's name if logged in or to the default message if not logged in
      screenLabel: AppLocalizations.of(context)!.lblWelcomeNotLogged,
      screenContent: const _StudentHomePageBody(),
    );
  }
}

class _StudentHomePageBody extends StatelessWidget {
  const _StudentHomePageBody();

  @override
  Widget build(BuildContext context) {
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
                    bookmarkButton: const BookmarkButton(size: 50.0),
                    onPressed: () => {});
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20.h); // Add padding between items
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
    return HostTemplateScreen(
      // TODO: screenLabel should be adapted to the host user's name
      screenLabel: AppLocalizations.of(context)!.lblWelcomeUser("<Name>"),
      screenContent: const _HostHomePageBody(),
    );
  }
}

class _HostHomePageBody extends StatelessWidget {
  const _HostHomePageBody();

  @override
  Widget build(BuildContext context) {
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
                        size: 30.w,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                    onPressed: () => {});
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20.h); // Add padding between items
              },
            ),
          ),
        ],
      ),
    );
  }
}
