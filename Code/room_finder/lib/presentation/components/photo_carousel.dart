// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';

/// [PhotoCarousel] is a widget that displays a carousel of images.
/// It is used in the app to display the images of a room or apartment.
/// It has a [CarouselSlider] widget that displays the images and a [LightBackButton] widget to go back.
/// In addition to that, it has a [_PhotoCounter] widget that displays the current image number.
///
/// The [PhotoCarousel] widget is an abstract class that defines the basic structure of the carousel.
/// It has two subclasses: [HostPhotoCarousel] and [StudentPhotoCarousel].
///
/// The [HostPhotoCarousel] is used by the host to display the images of the room or apartment, with the following buttons:
/// - [EditButton], to edit the images;
/// - [DeleteButton], to delete the images.
///
/// The [StudentPhotoCarousel] is used by the student to display the images of the room or apartment, with the following buttons:
/// - [BookmarkButton], to bookmark the room or apartment.
abstract class PhotoCarousel extends StatefulWidget {
  final List<Image> items;
  final bool isWizardPage;

  const PhotoCarousel({
    super.key,
    required this.items,
    this.isWizardPage = false,
  });

  bool get isStudent;

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    double carouselHeight = 348.0.h;

    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: carouselHeight,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: i.image,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          top: 2,
          child: LightBackButton(
            // TODO: maybe onPressed is fixed for back button
            onPressed: () {},
          ),
        ),
        widget.isStudent
            ? Positioned(
                height: carouselHeight,
                top: 2,
                right: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BookmarkButton(size: 50),
                    _PhotoCounter(current: _current, widget: widget)
                  ],
                ))
            : widget.isWizardPage ? Positioned(
                top: 2,
                right: 5,
                height: carouselHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EditButton(
                      onPressed: () {},
                    ),
                    DeleteButton(onPressed: () {}),
                    _PhotoCounter(current: _current, widget: widget),
                  ],
                ),
              )
              : const SizedBox.shrink(),
      ],
    );
  }
}

/// [_PhotoCounter] is a widget that displays the current image number.
/// It is used in the [PhotoCarousel] widget to display the current image number.
class _PhotoCounter extends StatelessWidget {
  const _PhotoCounter({
    required int current,
    required this.widget,
  }) : _current = current;

  final int _current;
  final PhotoCarousel widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface.withOpacity(0.85),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
        child: Text(
          "${_current + 1}/${widget.items.length}",
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// [HostPhotoCarousel] is a widget that displays a carousel of images for the host.
class HostPhotoCarousel extends PhotoCarousel {
  const HostPhotoCarousel({super.key, required super.items});

  @override
  bool get isStudent => false;
}

/// [StudentPhotoCarousel] is a widget that displays a carousel of images for the student.
class StudentPhotoCarousel extends PhotoCarousel {
  const StudentPhotoCarousel({super.key, required super.items});

  @override
  bool get isStudent => true;
}
