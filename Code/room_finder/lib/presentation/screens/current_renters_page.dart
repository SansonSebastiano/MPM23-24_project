import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/presentation/components/error_messages.dart';
import 'package:room_finder/presentation/components/renter_box.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/util/network_handler.dart';

class CurrentRentersPage extends ConsumerWidget {
  const CurrentRentersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var connectivityStatusProvider = ref.watch(networkAwareProvider);
    bool isOffline = connectivityStatusProvider == NetworkStatus.off;

    return SecondaryTemplateScreen(
      leftHeaderWidget: DarkBackButton(onPressed: () {}),
      centerHeaderWidget: Align(
        alignment: Alignment.center,
        // TODO: Replace with real data
        child: isOffline
            ? const SizedBox.shrink()
            : RichText(
                text: TextSpan(
                  text: "Casa dolce casa",
                  style: Theme.of(context).textTheme.displaySmall,
                  children: [
                    TextSpan(
                      text: "\nPadova - Via Roma 1",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
      ),
      content: isOffline
          ? Expanded(
              child: NoInternetErrorMessage(
                context: context,
              ),
            )
          : const _CurrentRentersBody(),
    );
  }
}

class _CurrentRentersBody extends StatelessWidget {
  const _CurrentRentersBody();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Text(
                  AppLocalizations.of(context)!.lblCurrRentDesc,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                // TODO: Replace with real data
                Text(AppLocalizations.of(context)!.lblCurrentRenters(2, 3),
                    style: Theme.of(context).textTheme.displaySmall),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                // TODO: Replace with real data
                return StudentRenterBox(
                  name: 'John Doe',
                  age: 23,
                  facultyOfStudies: "Computer Science",
                  interests: "Music, Sports",
                  contractDeadline: DateTime.now(),
                );
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
