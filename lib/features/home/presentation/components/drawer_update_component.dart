import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';
import '../../../../core/core_features/theme/presentation/utils/colors/app_static_colors.dart';
import '../../../../core/presentation/extensions/responsive_extensions.dart';
import '../../../../core/presentation/services/local_notfication_service/show_local_notification_provider.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/event.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/utils/toasts.dart';
import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import '../../../../core/presentation/widgets/platform_widgets/custom_show_bottom_sheet.dart';
import '../../domain/entity/todo.dart';
import '../../domain/use_case/update_item_uc.dart';
import '../provider/delete_item_provider.dart';
import '../provider/drawer_provider.dart';
import '../provider/select_time_of_day_provider.dart';
import '../provider/selected_item_provider.dart';
import '../provider/update_item_provider.dart';
import '../widgets/drawer_colors_item.dart';
import '../widgets/drawer_todo_detail_item.dart';
import '../widgets/drawer_todo_name_item.dart';
import '../widgets/drawr_date.dart';

class CustomUpdateDrawer extends HookConsumerWidget {
  const CustomUpdateDrawer({
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
    ref.easyListen(updateItemStateProvider);
    final taskFormKey = useMemoized(GlobalKey<FormState>.new);
    final time = ref.watch(selectTimeOfDayProvider);
    final color = ref.watch(selectColorItemProvider);
    final date = ref.watch(selectDateProvider);
    final nameController = useTextEditingController(text: todoItem.status);
    final descController = useTextEditingController(text: todoItem.description);
    final newDate = date.isNone()
        ? todoItem.date!.substring(0, 10)
        : date.toNullable().toString().substring(0, 10);
    final newTime = time.isNone()
        ? todoItem.time!
        : '${time.toNullable()!.hour.toString().padLeft(2, '0')}:${time.toNullable()!.minute.toString().padLeft(2, '0')}';

    tz.TZDateTime convertTime() {
      final now = tz.TZDateTime.now(tz.local);
      var scheduleDate = tz.TZDateTime(
        tz.local,
        int.parse(newDate.substring(0, 4)),
        int.parse(newDate.substring(5, 7).padLeft(2, '0')),
        int.parse(newDate.substring(8, 10).padLeft(2, '0')),
        int.parse(newTime.substring(0, 2).padLeft(2, '0')),
        int.parse(newTime.substring(3, 3).padLeft(2, '0')),
      );
      if (scheduleDate.isBefore(now)) {
        scheduleDate = scheduleDate.add(const Duration(days: 1));
      }

      return scheduleDate;
    }

    void updateItem() {
      final canSubmit = !ref.read(updateItemStateProvider).isLoading;

      if (DateTime(
        int.parse(newDate.substring(0, 4)),
        int.parse(newDate.substring(5, 7).padLeft(2, '0')),
        int.parse(newDate.substring(8, 10).padLeft(2, '0')),
        int.parse(newTime.substring(0, 2).padLeft(2, '0')),
        int.parse(newTime.substring(3, 5).padLeft(2, '0')),
      ).isBefore(
        DateTime.now(),
      )) {
        Toasts.showBackgroundMessageToast(
          context,
          message: 'You should select a comming time first',
        );
      } else if (canSubmit && taskFormKey.currentState!.validate()) {
        drawerController.close!();

        final params = UpdateItemParams(
          todo: todoItem.copyWith(
            color: color.isNone() ? todoItem.color : color.toNullable()!.value,
            date: newDate,
            time: newTime,
            description: descController.text,
            itemId: const Uuid().v4(),
            status: nameController.text,
          ),
          oldId: todoItem.itemId!,
        );
        ref.listenWhile(updateTodoItemEventProvider, (notifier) async {
          notifier.update((_) => Some(Event.unique(params)));
          final notifacionParams = ShowLocalNotificationParams(
            title: 'Reminder',
            body: params.todo.status,
            zonedTime: convertTime(),
          );
          ref.read(showLocalNotificationProvider(notifacionParams));
          ref.read(
            scheduleReminderotificationProvider(notifacionParams),
          );
        });
      }
    }

    void deleteItem() {
      final canSubmit = !ref.read(deleteItemStateProvider).isLoading;

      if (canSubmit) {
        //    scaffoldKey.currentState!.closeEndDrawer();
        ref.listenWhile(deleteItemEventProvider, (notifier) async {
          notifier.update((_) => Some(Event.unique(todoItem.itemId!)));
          await Toasts.showBackgroundMessageToast(
            context,
            message: 'Item dismissed',
          );
        });
      } else {}
    }

    return Container(
      decoration: const BoxDecoration(gradient: AppStaticColors.drawer),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.marginV16,
          horizontal: Sizes.marginH17,
        ),
        child: Form(
          key: taskFormKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: context.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: Sizes.marginV16,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: CustomText.f20(
                      context,
                      'Update Task',
                      color: AppStaticColors.blue,
                      weight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.marginV32,
                  ),
                  DrawerColorsItem(
                    todoItem: color.isSome() ? null : todoItem,
                    isBottomShhet: false,
                  ),
                  const SizedBox(
                    height: Sizes.marginV20,
                  ),
                  DrawerToDoNameItem(controller: nameController),
                  const SizedBox(
                    height: Sizes.marginV32,
                  ),
                  DrawerToDoDetailItem(controller: descController),
                  const SizedBox(
                    height: Sizes.marginV28,
                  ),
                  DrawerDateItem(
                    onTap: () async {
                      final dateTime = await showPlatformDatePicker<void>(
                        context: context,
                      );
                      if (dateTime != null) {
                        ref
                            .watch(selectDateProvider.notifier)
                            .update((state) => state = Some(dateTime));
                      }
                    },
                    dateTime: date.toNullable() ??
                        DateTime(
                          int.parse(todoItem.date!.substring(0, 4)),
                          int.parse(todoItem.date!.substring(5, 7)),
                          int.parse(todoItem.date!.substring(8, 10)),
                        ),
                    title: 'Date',
                  ),
                  const SizedBox(
                    height: Sizes.marginV28,
                  ),
                  DrawerDateItem(
                    onTap: () async {
                      final timepicker =
                          await showPlatformTimePicker<TimeOfDay?>(
                        context: context,
                      );
                      if (timepicker != null) {
                        ref
                            .watch(selectTimeOfDayProvider.notifier)
                            .update((state) => state = Some(timepicker));
                      }
                    },
                    timeofDay: time.toNullable() ??
                        TimeOfDay(
                          hour: int.parse(todoItem.time!.substring(0, 2)),
                          minute: int.parse(todoItem.time!.substring(3, 5)),
                        ),
                    title: 'Time',
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            onPressed: ref.isLoading(deleteItemStateProvider)
                                ? null
                                : deleteItem,
                            text: 'Delete',
                            width: Sizes.buttonWidth120,
                            buttonColor: const Color.fromRGBO(227, 0, 0, 1),
                          ),
                          CustomButton(
                            onPressed:
                                ref.read(updateItemStateProvider).isLoading
                                    ? null
                                    : updateItem,
                            text: 'Update',
                            width: Sizes.buttonWidth120,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Sizes.marginV20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
