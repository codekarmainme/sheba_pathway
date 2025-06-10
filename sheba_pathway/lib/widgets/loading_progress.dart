import 'package:flutter/material.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingProgress(BuildContext context) {
  return Center(
    child: LoadingAnimationWidget.discreteCircle(
      color: successColor,
      secondRingColor: warningColor,
      thirdRingColor: errorColor,
      size: 50,
    ),
  );
}
