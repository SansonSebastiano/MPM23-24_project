import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/ads_box.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/error_messages.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/util/network_handler.dart';

class SavedAdsPage extends ConsumerWidget {
  const SavedAdsPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus = ref.watch(networkAwareProvider);

    return StudentTemplateScreen(
      screenLabel: AppLocalizations.of(context)!.lblSavedAds, 
      screenContent: networkStatus == NetworkStatus.off
          ? Center(heightFactor: 6.h, child: NoInternetErrorMessage(context: context)) 
          : const SavedAdsPageBody(),
    );
  }
}

class SavedAdsPageBody extends StatelessWidget {
  const SavedAdsPageBody({super.key});
  
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
              itemCount: 4, 
              itemBuilder: (BuildContext context, int index) {
                return AdsBox(
                  imageUrl: "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg", 
                  city: "Padova", 
                  street: "Via Roma 12", 
                  price: 300, 
                  bookmarkButton: const BookmarkButton(size: 50.0),
                  onPressed: () => {} 
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
