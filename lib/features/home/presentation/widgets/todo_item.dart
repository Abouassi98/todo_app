import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/core_features/theme/presentation/utils/colors/app_static_colors.dart';
import '../../../../core/presentation/extensions/responsive_extensions.dart';
import '../../../../core/presentation/styles/font_styles.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/event.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/utils/toasts.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import '../../domain/entity/todo.dart';
import '../provider/delete_item_provider.dart';
import '../provider/drawer_provider.dart';
import '../provider/selected_item_provider.dart';

class TodoItem extends ConsumerWidget {
  const TodoItem({
    required this.todoItem,
    super.key,
  });

  final Todo todoItem;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final drawerController = ref.watch(zoomDrawerControllerProvider);
    ref.easyListen(deleteItemStateProvider);
    Future<bool> deleteItem() async {
      final canSubmit = !ref.read(deleteItemStateProvider).isLoading;

      if (canSubmit) {
        await ref.listenWhile(deleteItemEventProvider, (notifier) async {
          notifier.update((_) => Some(Event.unique(todoItem.itemId!)));
          await Toasts.showBackgroundMessageToast(
            context,
            message: 'Item dismissed',
          );
        });

        return true;
      } else {
        return false;
      }
    }

    return GestureDetector(
      onTap: () async {
        ref.read(clearSelectedItemAndColorProvider);
  
        ref
            .watch(selectedItemProvider.notifier)
            .update((state) => state = Some(todoItem));
        await drawerController.open!();
      },
      child: Dismissible(
        key: ValueKey(todoItem.itemId),
        confirmDismiss: (_) async =>
            ref.isLoading(deleteItemStateProvider) ? null : deleteItem(),
        child: Card(
          surfaceTintColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: Sizes.dialogPaddingH10,
                      ),
                      SizedBox(
                        height: Sizes.marginV16,
                        width: Sizes.marginH16,
                        child: CircleAvatar(
                          backgroundColor: Color(todoItem.color!),
                        ),
                      ),
                      const SizedBox(
                        width: Sizes.marginH16,
                      ),
                      SizedBox(
                        width: context.width * 0.4,
                        child: CustomText.f14(
                          context,
                          todoItem.description!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          color: AppStaticColors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        CustomText.f12(
                          context,
                          todoItem.date!.substring(8, 10),
                          color: AppStaticColors.blue.withOpacity(0.8),
                          weight: FontStyles.fontWeightBold,
                        ),
                        const SizedBox(width: Sizes.marginH4),
                        CustomText.f12(
                          context,
                          DateFormat('MMMM').format(
                            DateTime(
                              int.parse(todoItem.date!.substring(0, 4)),
                              int.parse(todoItem.date!.substring(5, 7)),
                            ),
                          ),
                          color: AppStaticColors.blue.withOpacity(0.8),
                          weight: FontStyles.fontWeightBold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Sizes.paddingV4,
                    ),
                    CustomText.f12(
                      context,
                      todoItem.time!,
                      weight: FontWeight.w100,
                    ),
                  ],
                ),
                const SizedBox(
                  height: Sizes.dialogPaddingH10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
