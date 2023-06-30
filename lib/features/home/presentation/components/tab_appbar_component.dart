// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:go_router/go_router.dart';
// import '../../../../core/presentation/routing/app_router.dart';
// import '../../../../core/presentation/widgets/custom_app_bar_widget.dart';
// import '../../../../core/presentation/widgets/custom_bottom_sheet.dart';
// import '../../../../core/presentation/widgets/platform_widgets/custom_show_bottom_sheet.dart';
// import '../widgets/app_bar_icon.dart';

// /// The default height of the toolbar component of the [AppBar].
// const double kToolbarHeight = 56;

// class PreferredAppBarSize extends Size {
//   PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
//       : super.fromHeight(
//           (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0),
//         );

//   final double? toolbarHeight;
//   final double? bottomHeight;
// }

// class TabAppBarComponent extends StatelessWidget
//     implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
//   TabAppBarComponent({
//     this.toolbarHeight,
//     this.bottom,
//     this.backgroundColor,
//     super.key,
//   }) : preferredSize =
//             PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);

//   //ToolbarHeight for Android/iOS and BackgroundColor for iOS must be pre-initialized, as we
//   //implementing PreferredSizeWidget, ObstructingPreferredSizeWidget to be able to rebuild only the appbar.
//   final double? toolbarHeight;
//   final PreferredSizeWidget? bottom;
//   final Color? backgroundColor;

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     final location = GoRouterState.of(context).location;

//     /// Home Tab
//     if (location == const HomeShellRoute().location) {
//       return CustomAppBar(
//         context,
//         trailingActions: [
//           IconButton(
//             icon: const AppBarIcon(),
//             onPressed: () => showPlatformModalSheet<Object>(
//               context: context,
//               builder: (context) => CupertinoActionSheet(
//                 actions: <Widget>[
//                   SizedBox(
//                     height: MediaQuery.sizeOf(context).height * 0.5,
//                     child: const CustomBottomSheet(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     }

//     return CustomAppBar(context);
//   }

//   @override
//   final Size preferredSize;

//   @override
//   bool shouldFullyObstruct(BuildContext context) {
//     final backgroundColor =
//         CupertinoDynamicColor.maybeResolve(this.backgroundColor, context) ??
//             CupertinoTheme.of(context).barBackgroundColor;
//     return backgroundColor.alpha == 0xFF;
//   }
// }
