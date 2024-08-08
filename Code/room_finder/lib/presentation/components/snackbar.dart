import 'package:flutter/material.dart';
import 'package:room_finder/style/color_palette.dart';

void showSuccessSnackBar(BuildContext context, String snackText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: ColorPalette.success,
      content: Text(
        snackText,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
      ),
    ),
  );
}

void showErrorSnackBar(BuildContext context, String snackText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: ColorPalette.error,
      content: Text(
        snackText,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
      ),
    ),
  );
}
