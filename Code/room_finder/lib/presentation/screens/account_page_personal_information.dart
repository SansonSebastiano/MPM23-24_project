import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/buttons/rectangle_buttons.dart';
import 'package:room_finder/presentation/components/input_text_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/components/profile_photo_editor.dart';
import 'package:room_finder/presentation/components/snackbar.dart';
import 'package:room_finder/util/network_handler.dart';

class PersonalInformationPage extends ConsumerStatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  ConsumerState<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState
    extends ConsumerState<PersonalInformationPage> {
  late TextEditingController _nameController;

  bool _isNameChanged = false;
  bool _isPhotoChanged = false;

  @override
  void initState() {
    super.initState();
    // FIXME: see below FIXME for the initial value
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onNameValidityChanged(bool isValid) {
    setState(() {
      _isNameChanged = isValid;
    });
  }

  void _onPhotoChanged(File? photo) {
    setState(() {
      _isPhotoChanged = photo != null;
    });
  }

  void _handleSubmitChanges() {
    if (_isNameChanged || _isPhotoChanged) {
      final networkStatus = ref.read(networkAwareProvider);

      if (networkStatus == NetworkStatus.off) {
        showErrorSnackBar(context, "No internet connection. Please try again.");
      } else {
        // Proceed submitting changes
        print("changing user information...");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DarkBackButton(onPressed: () => Navigator.pop(context)),
                      SizedBox(height: 20.h),
                      SizedBox(height: 20.h),
                      Text(AppLocalizations.of(context)!.btnPersonalInfo,
                          style: Theme.of(context).textTheme.displayMedium),
                      SizedBox(height: 20.h),
                      Text(AppLocalizations.of(context)!.lblPersonalInformation,
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 40.h),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.lblAccountPhoto,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: ProfilePhotoEditor(
                          imageUrl:
                              "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-per-foto-uomo-selfie.jpg",
                          onPhotoChanged: _onPhotoChanged,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      StandardTextField(
                          label: AppLocalizations.of(context)!.lblName,
                          onValueValidityChanged: _onNameValidityChanged,
                          controller: _nameController,
                          // FIXME: fix the initial value in the initState of the current page
                          initialValue: "Francesco" // to retrieve from backend
                          ),
                      SizedBox(height: 40.h),
                      Center(
                        child: Stack(
                          children: [
                            RectangleButton(
                              label: "Submit changes",
                              onPressed: _handleSubmitChanges,
                            ),
                            if (!_isNameChanged && !_isPhotoChanged)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
