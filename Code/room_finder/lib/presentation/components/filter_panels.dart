// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/amenities_option.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Create a filter panel implementing the [BaseFilterPanel] abstract class.
/// The filter panel contains a [title] and a list of [items].
abstract class BaseFilterPanel extends StatelessWidget {
  final String title;

  const BaseFilterPanel({super.key, required this.title});

  Widget get items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.h),
            _FilterTitle(
              title: title,
            ),
            SizedBox(height: 10.h),
            const Divider(
              thickness: 2,
            ),
            SizedBox(height: 20.h),
            items,
            // TODO: add confirm button
            // SizedBox(height: 20.h),
            // ElevatedButton(onPressed: () {}, child: const Text('Apply Filters'))
          ],
        ),
      ),
    );
  }
}

/// Show the filter panel.
///
/// The [filterPanel] is the panel to be shown.
///
/// The [context] is the context of the app.
Future showFilterPanel(
    {required BuildContext context, required BaseFilterPanel filterPanel}) {
  return showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    backgroundColor: ColorPalette.lavenderBlue,
    builder: (BuildContext context) {
      return filterPanel;
    },
  );
}

/// Create a [title] for the filter panel.
class _FilterTitle extends StatelessWidget {
  final String title;

  const _FilterTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close)),
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const Visibility(
            visible: false,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: IconButton(onPressed: null, icon: Icon(Icons.close))),
      ],
    );
  }
}

/// Create a filter item implementing the [_FilterItem] abstract class.
/// The filter item requires a [itemTitle] and an optional [itemDesc].
/// The [content] is the main content of the filter item.
abstract class _FilterItem extends StatelessWidget {
  final String itemTitle;
  final String? itemDesc;

  const _FilterItem({
    // ignore: unused_element
    required this.itemTitle,
    this.itemDesc = '',
  });

  Widget get content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 26.w),
            child: RichText(
              text: TextSpan(
                text: itemTitle,
                style: Theme.of(context).textTheme.displaySmall,
                children: [
                  TextSpan(
                    text: '\n$itemDesc',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        content,
        SizedBox(height: 20.h),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}

// Creation of the filters panels.

class SearchFilterPanel extends BaseFilterPanel {
  final BuildContext context;

  const SearchFilterPanel(
      {super.key, required this.context, required super.title});

  @override
  Widget get items => Column(
        children: [
          _PriceRangeItem(
            context: context,
            itemTitle: AppLocalizations.of(context)!.lblPriceRange,
            itemDesc: AppLocalizations.of(context)!.lblPriceDesc,
          ),
          _AmenitiesItem(
            itemTitle: AppLocalizations.of(context)!.lblAmenities,
          ),
          _RoomsItem(
            itemTitle: AppLocalizations.of(context)!.lblBedrooms,
          ),
          _RoomsItem(
            itemTitle: AppLocalizations.of(context)!.lblBeds,
          ),
          _RoomsItem(
            itemTitle: AppLocalizations.of(context)!.lblBathrooms,
          ),
          _RoomsItem(
            itemTitle: AppLocalizations.of(context)!.lblRoommates,
          ),
        ],
      );
}

/// Create a custom range slider.
/// The range slider has a minimum value of 0 and a maximum value of <TO BE DEFINED STATICALLY/DINAMICALLY>.
class _CustomRangeSlider extends StatefulWidget {
  const _CustomRangeSlider();

  @override
  State<_CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<_CustomRangeSlider> {
  // TODO: the end should be the max value from the backend
  RangeValues _currentRangeValues = const RangeValues(0, 1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          values: _currentRangeValues,
          // TODO: it should be taken from the backend, the max value
          max: 1000,
          divisions: 100,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
        Row(
          children: [
            Text(
              _currentRangeValues.start.round().toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            Text(
              _currentRangeValues.end.round().toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}

/// Create a price range filter item.
class _PriceRangeItem extends _FilterItem {
  final BuildContext context;

  // ignore: unused_element
  const _PriceRangeItem(
      {required this.context, required super.itemTitle, super.itemDesc});

  @override
  Widget get content {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: const _CustomRangeSlider());
  }
}

class _AmenitiesItem extends _FilterItem {
  // ignore: unused_element
  _AmenitiesItem({required super.itemTitle, super.itemDesc});

  // TODO: to be parametrized
  final List<AmenitiesOption> amenitiesOptions = <AmenitiesOption>[
    const AmenitiesOption(label: 'label'),
    const AmenitiesOption(label: 'label'),
    const AmenitiesOption(label: 'label'),
    const AmenitiesOption(label: 'label'),
    const AmenitiesOption(label: 'label'),
    const AmenitiesOption(label: 'label'),
  ];

  @override
  Widget get content {
    return SizedBox(
      height: 100.h,
      // TODO: maybe change the widget in order to get data from firebase and limit the number of amenities, then add the possibility to show more options
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: amenitiesOptions.length,
          itemBuilder: (BuildContext context, int index) {
            return amenitiesOptions[index];
          }),
    );
  }
}

/// Customization of the [ChoiceChip] widget.
/// 
/// It allows to select only one option at a time from a list of options [any, 1, 2, 3, 4, 5].
class _CustomChoiceChip extends StatefulWidget {
  const _CustomChoiceChip();

  @override
  State<_CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<_CustomChoiceChip> {
  int _selectedIndex = 0;
  final List<String> _options = <String>['Any', '1', '2', '3', '4', '5'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: _options.asMap().entries.map((MapEntry<int, String> entry) {
        return ChoiceChip(
          label: Text(entry.value),
          selected: _selectedIndex == entry.key,
          onSelected: (bool selected) {
            setState(() {
              _selectedIndex = selected ? entry.key : 0;
            });
          },
        );
      }).toList(),
    );
  }
}

/// Create a filter item for the number of rooms.
/// 
/// The filter item allows to select the number of rooms from a list of options [any, 1, 2, 3, 4, 5].
/// 
/// The [content] is a [_CustomChoiceChip] widget.
class _RoomsItem extends _FilterItem {
  // ignore: unused_element
  const _RoomsItem({required super.itemTitle, super.itemDesc});

  @override
  Widget get content {
    return const _CustomChoiceChip();
  }
}

// TODO: DatePicker for the initial date of the contract