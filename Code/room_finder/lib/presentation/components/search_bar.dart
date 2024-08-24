import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/screens/search_results_page.dart';
import 'package:room_finder/style/color_palette.dart';

/// This class contains the [CustomSearchBar] widget, which is a custom search bar that can be used in the app.
///
/// - [hintText] is the text that appears as a hint in the search bar.
class CustomSearchBar extends StatelessWidget {
  final String? hintText;
  final bool isLogged;
  // TODO: check eventually if other parameters are needed
  // TODO: cities autocomplete
  // TODO: In the searched results page, once invoked, the search bar, initially, has not a hint text, but the searched text
  const CustomSearchBar({super.key, this.hintText, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
      return SizedBox(
        height: 48.h,
        child: SearchBar(
          textStyle: WidgetStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.bodyMedium!,
          ),
          controller: controller,
          backgroundColor: WidgetStateProperty.all<Color>(
              ColorPalette.lavenderBlue.withOpacity(0.5)),
          elevation: WidgetStateProperty.all<double>(0),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          hintText: hintText,
          trailing: [
            IconButton(
              onPressed: () {
                // TODO: Replace with real data
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchResultsPage(
                    isLogged: isLogged,
                  );
                }));
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
      );
    }, suggestionsBuilder: (BuildContext context, SearchController controller) {
      // Add a return statement here
      return [];
    });
  }
}
