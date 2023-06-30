import 'package:flutter/material.dart';
import '../../../../core/core_features/theme/presentation/utils/colors/app_static_colors.dart';
import '../../../../core/presentation/routing/navigation_service.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../domain/entity/todo.dart';
import '../provider/filter_item_provider.dart';
import '../provider/selected_item_provider.dart';
import 'custom_drawer_container.dart';

class DrawerColorsItem extends HookConsumerWidget {
  const DrawerColorsItem({
    required this.isBottomShhet,
    super.key,
    this.todoItem,
  });
  final Todo? todoItem;
  final bool isBottomShhet;
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    //padding: const EdgeInsets.symmetric(vertical: Sizes.marginV20),
    return CustomDrawerContainer(
      label: 'Color',
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: SizedBox(
          height: Sizes.imageR56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: AppStaticColors.drawerColor
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      if (isBottomShhet) {
                        NavigationService.pop<int>(context);
                        ref
                            .watch(filterColorItemProvider.notifier)
                            .update((state) => state = Some(e));
                      } else {
                        ref
                            .watch(selectColorItemProvider.notifier)
                            .update((state) => state = Some(e));
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: Sizes.marginV28,
                          width: Sizes.marginH28,
                          child: CircleAvatar(
                            backgroundColor: e,
                          ),
                        ),
                        if ((!isBottomShhet &&
                                ref
                                        .watch(selectColorItemProvider)
                                        .toNullable() ==
                                    e) ||
                            (isBottomShhet &&
                                ref
                                        .watch(filterColorItemProvider)
                                        .toNullable() ==
                                    e) ||
                            Color(
                                  todoItem != null
                                      ? todoItem!.color!
                                      : 0xFFFF9000,
                                ) ==
                                e)
                          const Icon(Icons.done, color: Colors.white),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
