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
import '../provider/add_item_provider.dart';
import '../provider/drawer_provider.dart';
import '../provider/filter_item_provider.dart';
import '../provider/select_time_of_day_provider.dart';
import '../provider/selected_item_provider.dart';
import '../widgets/drawer_colors_item.dart';
import '../widgets/drawer_todo_detail_item.dart';
import '../widgets/drawer_todo_name_item.dart';
import '../widgets/drawr_date.dart';

class CustomDrawer extends HookConsumerWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.easyListen(addItemStateProvider);
    final drawerController = ref.watch(zoomDrawerControllerProvider);
    final taskFormKey = useMemoized(GlobalKey<FormState>.new);
    final time = ref.watch(selectTimeOfDayProvider);
    final color = ref.watch(selectColorItemProvider);
    final date = ref.watch(selectDateProvider);
    final nameController = useTextEditingController(text: '');
    final descController = useTextEditingController(text: '');
    tz.TZDateTime convertTime() {
      final now = tz.TZDateTime.now(tz.local);

      var scheduleDate = tz.TZDateTime(
        tz.local,
        date.toNullable()!.year,
        int.parse(date.toNullable()!.month.toString().padLeft(2, '0')),
        int.parse(date.toNullable()!.day.toString().padLeft(2, '0')),
        int.parse(time.toNullable()!.hour.toString().padLeft(2, '0')),
        int.parse(time.toNullable()!.minute.toString().padLeft(2, '0')),
      );
      if (scheduleDate.isBefore(now)) {
        scheduleDate = scheduleDate.add(const Duration(days: 1));
      }

      return scheduleDate;
    }

    void addItem() {
      final canSubmit = !ref.read(addItemStateProvider).isLoading;
      if (color.isNone()) {
        Toasts.showBackgroundMessageToast(
          context,
          message: 'You should select a color first',
        );
      } else if (date.isNone()) {
        Toasts.showBackgroundMessageToast(
          context,
          message: 'You should select a date first',
        );
      } else if (time.isNone()) {
        Toasts.showBackgroundMessageToast(
          context,
          message: 'You should select a time first',
        );
      } else if (canSubmit && taskFormKey.currentState!.validate()) {
        drawerController.close!();
        ref.read(clearFilterDateAndColorProvider);

        final params = Todo(
          color: color.toNullable()!.value,
          date: date.toNullable().toString().substring(0, 10),
          time:
              '${time.toNullable()!.hour.toString().padLeft(2, '0')}:${time.toNullable()!.minute.toString().padLeft(2, '0')}',
          description: descController.text,
          itemId: const Uuid().v4(),
          status: nameController.text,
        );

        ref.listenWhile(addTodoItemEventProvider, (notifier) async {
          notifier.update((_) => Some(Event.unique(params)));
          final notifacionParams = ShowLocalNotificationParams(
            title: 'Reminder',
            body: params.status,
            zonedTime: convertTime(),
          );
          nameController.clear();
          descController.clear();

          ref.read(showLocalNotificationProvider(notifacionParams));
          ref.read(
            scheduleReminderotificationProvider(notifacionParams),
          );
        });
      }
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
                      'NEW TASK',
                      color: AppStaticColors.blue,
                      weight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.marginV32,
                  ),
                  const DrawerColorsItem(isBottomShhet: false),
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
                    dateTime: date.toNullable() ?? DateTime.now(),
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
                    timeofDay: time.toNullable() ?? TimeOfDay.now(),
                    title: 'Time',
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomButton(
                        onPressed: ref.isLoading(addItemStateProvider)
                            ? null
                            : addItem,
                        text: 'Add',
                        width: Sizes.buttonWidth136,
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
