import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/amenities_option.dart';
import 'package:room_finder/presentation/components/base_panel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [SearchFilterPanel] is a filter panel that contains a list of filter items, in order to filter the search results.
///
/// The filter items are:
///
/// - Price range
///
/// - Amenities
///
/// - Bedrooms
///
/// - Beds
///
/// - Bathrooms
///
/// - Roommates
class SearchFilterPanel extends BaseModalPanel {
  final BuildContext context;

  const SearchFilterPanel(
      {super.key,
      required this.context,
      required super.title,
      required super.btnLabel,
      required super.onBtnPressed,
      required super.onBtnClosed});

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
            amenitiesOptions: [
              AmenitiesOption(label: AppLocalizations.of(context)!.lblWiFi),
              AmenitiesOption(
                  label: AppLocalizations.of(context)!.lblDishwasher),
              AmenitiesOption(
                  label: AppLocalizations.of(context)!.lblWashingMachine),
              AmenitiesOption(label: AppLocalizations.of(context)!.lblDryer),
              AmenitiesOption(
                  label: AppLocalizations.of(context)!.lblDedicatedParking),
              AmenitiesOption(
                  label: AppLocalizations.of(context)!.lblAirConditioning),
              AmenitiesOption(label: AppLocalizations.of(context)!.lblHeating),
            ],
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
class _PriceRangeItem extends PanelItem {
  final BuildContext context;

  const _PriceRangeItem(
      {required this.context, required super.itemTitle, super.itemDesc});

  @override
  Widget get content {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: const _CustomRangeSlider());
  }
}

/// Create a filter item for the amenities.
class _AmenitiesItem extends PanelItem {
  final List<AmenitiesOption> amenitiesOptions;

  const _AmenitiesItem(
      {required super.itemTitle, required this.amenitiesOptions});

  @override
  Widget get content {
    return SizedBox(
      height: 100.h,
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
  final List<String> _options = <String>['Any', '1', '2', '3', '4'];

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
class _RoomsItem extends PanelItem {
  const _RoomsItem({required super.itemTitle});

  @override
  Widget get content {
    return const _CustomChoiceChip();
  }
}
