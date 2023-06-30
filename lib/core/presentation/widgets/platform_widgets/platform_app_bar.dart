import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'platform_base_widget.dart';

class PlatformAppBar
    extends PlatformBaseWidget<SliverAppBar, CupertinoSliverNavigationBar> {
  const PlatformAppBar({
    super.key,
    this.widgetKey,
    this.toolbarHeight,
    this.backgroundColor,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.materialData,
    this.cupertinoData,
    this.shapeBorder,
  });

  final Key? widgetKey;
  final double? toolbarHeight;
  final Color? backgroundColor;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final ShapeBorder? shapeBorder;
  final List<Widget>? actions;
  final MaterialAppBarData? materialData;
  final CupertinoNavigationBarData? cupertinoData;

  @override
  SliverAppBar createMaterialWidget(BuildContext context) {
    return SliverAppBar(
      key: widgetKey,
      toolbarHeight: toolbarHeight!,
      backgroundColor: backgroundColor,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      centerTitle: materialData?.centerTitle,
      elevation: materialData?.elevation,
      titleSpacing: materialData?.titleSpacing,
      leadingWidth: materialData?.leadingWidth,
      shape: shapeBorder,
    );
  }

  @override
  CupertinoSliverNavigationBar createCupertinoWidget(BuildContext context) {
    return CupertinoSliverNavigationBar(
      key: widgetKey,
      backgroundColor: backgroundColor,
      largeTitle: const SizedBox.shrink(),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      middle: title,
      trailing: actions?.isEmpty ?? true
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: actions!,
            ),
      border: cupertinoData?.border,
      transitionBetweenRoutes: cupertinoData?.transitionBetweenRoutes ?? true,
    );
  }
}

class MaterialAppBarData {
  const MaterialAppBarData({
    this.centerTitle,
    this.elevation,
    this.titleSpacing,
    this.leadingWidth,
  });

  final bool? centerTitle;
  final double? elevation;
  final double? titleSpacing;
  final double? leadingWidth;
}

class CupertinoNavigationBarData {
  const CupertinoNavigationBarData({
    this.transitionBetweenRoutes,
    this.border,
  });

  final bool? transitionBetweenRoutes;
  final Border? border;
}
