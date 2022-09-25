
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  double? width;
  double? heigth;
  final ShapeBorder shapeBorder;

  ShimmerWidget.rectangular({Key? key,
    required this.width,
    required this.heigth,
    this.shapeBorder = const RoundedRectangleBorder(),
  }) : super(key: key);

  ShimmerWidget.circular({Key? key,
    required this.width,
    required this.heigth,
    this.shapeBorder = const CircleBorder(),
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        width: width,
        height: heigth,
        decoration:  ShapeDecoration(
          color: Colors.grey[400]!,
          shape: shapeBorder,
        ),
      ),
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,

    );
  }
}