import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/style/color_palette.dart';

/// This class contains the [CustomSearchBar] widget, which is a custom search bar that can be used in the app.
/// - [width] is the width of the search bar.
/// - [hintText] is the text that appears as a hint in the search bar.
class CustomSearchBar extends StatelessWidget {
  final double width;
  final String hintText;
  // TODO: check eventually if other parameters are needed
  // TODO: cities autocomplete

  const CustomSearchBar(
      {super.key, required this.width, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
      return SizedBox(
        width: width.w,
        height: 48.h,
        child: SearchBar(
          controller: controller,
          backgroundColor:
              WidgetStateProperty.all<Color>(ColorPalette.lavenderBlue),
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
                // TODO: Implement search functionality
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
