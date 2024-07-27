import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The class [CustomNavigationBar] represents a navigation destination.
/// This class contains the icon and label of the destination.
/// The icon is displayed on the navigation bar, and the label is displayed below the icon.
/// The label is used to describe the destination.
/// The icon is used to represent the destination.
/// [isHost] is a boolean value that determines if the user is a host, in order to display the correct destinations.
class CustomNavigationBar extends StatefulWidget {
  final bool isHost;

  const CustomNavigationBar({super.key, required this.isHost});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> studentDestination = [
      NavigationDestination(
        icon: const Icon(Icons.search),
        label: AppLocalizations.of(context)!.lblEnterCity,
      ),
      NavigationDestination(
        icon: const Icon(Icons.bookmark_border_outlined),
        label: AppLocalizations.of(context)!.btnSavedAds,
      ),
      NavigationDestination(
        icon: const Icon(Icons.chat_bubble_outline_rounded),
        label: AppLocalizations.of(context)!.btnChat,
      ),
      NavigationDestination(
        icon: const Icon(Icons.person_outline_rounded),
        label: AppLocalizations.of(context)!.btnProfile,
      ),
    ];

    final List<Widget> hostDestination = [
      NavigationDestination(
        icon: const Icon(Icons.bookmark_border_outlined),
        label: AppLocalizations.of(context)!.btnAds,
      ),
      NavigationDestination(
        icon: const Icon(Icons.chat_bubble_outline_rounded),
        label: AppLocalizations.of(context)!.btnChat,
      ),
      NavigationDestination(
        icon: const Icon(Icons.person_outline_rounded),
        label: AppLocalizations.of(context)!.btnProfile,
      ),
    ];

    return NavigationBar(
      destinations: widget.isHost ? hostDestination : studentDestination,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      selectedIndex: currentPageIndex,
    );
  }
}
