import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/ads_box.dart';
import 'package:room_finder/presentation/components/base_panel.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/filter_panel.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:room_finder/presentation/components/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});
  
  void _showSearchFilterPanel(BuildContext context) {
    showModalPanel(
      context: context, 
      panel: SearchFilterPanel(
        context: context, 
        title: "Filters", 
        btnLabel: AppLocalizations.of(context)!.btnApplyFilters
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SecondaryTemplateScreen(
      leftHeaderWidget: DarkBackButton(onPressed: () => Navigator.pop(context)), 
      centerHeaderWidget: const CustomSearchBar(hintText: "Padova"), 
      rightHeaderWidget: FilterButton(onPressed: () => _showSearchFilterPanel(context)),
      rightHeaderWidgetVisibility: true,
      content: const SearchResultsPageBody()
    );
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
    );
  }
}