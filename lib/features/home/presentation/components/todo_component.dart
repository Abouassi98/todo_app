import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/presentation/extensions/responsive_extensions.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/utils/scroll_behaviors.dart';
import '../../../../core/presentation/widgets/custom_app_bar_widget.dart';
import '../../../../core/presentation/widgets/custom_bottom_sheet.dart';
import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import '../../../../core/presentation/widgets/loading_indicators.dart';
import '../../../../core/presentation/widgets/platform_widgets/custom_show_bottom_sheet.dart';
import '../../../../core/presentation/widgets/platform_widgets/platform_refresh_indicator.dart';
import '../provider/drawer_provider.dart';
import '../provider/get_items_provider.dart';
import '../provider/filter_item_provider.dart';
import '../provider/select_time_of_day_provider.dart';
import '../provider/selected_item_provider.dart';
import '../widgets/app_bar_icon.dart';
import 'item_list_component.dart';

class ToDoComponent extends HookConsumerWidget {
  const ToDoComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(getItemsProvider);
    final color = ref.watch(filterColorItemProvider);
    final date = ref.watch(filterDateItemProvider);
    return Stack(
      children: [
        ScrollConfiguration(
          behavior: MainScrollBehavior(),
          child: itemsAsync.when(
            skipLoadingOnReload: false,
            skipLoadingOnRefresh: !itemsAsync.hasError,
            data: (items) {
              final reversedList = items.reversed.toList();
              final filterdList = ref.watch(filterListProvider(reversedList));
              return CustomScrollView(
                slivers: [
                  CustomAppBar(
                    context,
                    trailingActions: [
                      IconButton(
                        icon: const AppBarIcon(),
                        onPressed: () => showPlatformModalSheet<Object>(
                          context: context,
                          builder: (context) => const CustomBottomSheet(),
                          cupertinoBuilder: (context) => CupertinoPageScaffold(
                            child: SizedBox(
                              height: context.height * 0.5,
                              child: const CustomBottomSheet(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ItemListComponent(
                    items: color.isSome() || date.isSome()
                        ? filterdList
                        : reversedList,
                  )
                ],
              );
            },
            error: (error, st) => PlatformRefreshIndicator(
              onRefresh: () => ref.refresh(getItemsProvider.future),
              slivers: [
                SliverFillRemaining(
                  child: Center(
                    child: CustomText.f20(
                      context,
                      'something Went Wrong \n please Try Again',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            loading: () => const Center(child: SmallLoadingAnimation()),
          ),
        ),
        Positioned(
          bottom: Sizes.bottomNavBarIconR22,
          right: Sizes.paddingH20,
          child: CustomButton(
            onPressed: () async {
             ref.read(clearSelectedDateAndTimeProvider);
              ref.read(clearSelectedItemAndColorProvider);
              await ref.watch(zoomDrawerControllerProvider).open!();
            },
            height: Sizes.buttonHeight60,
            width: Sizes.buttonWidth60,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
