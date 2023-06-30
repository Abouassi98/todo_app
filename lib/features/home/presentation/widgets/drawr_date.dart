import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import 'custom_drawer_container.dart';

class DrawerDateItem extends HookConsumerWidget {
  const DrawerDateItem({
    required this.title,
    required this.onTap,
    this.dateTime,
    this.timeofDay,
    super.key,
  });
  final void Function() onTap;
  final String title;
  final TimeOfDay? timeofDay;
  final DateTime? dateTime;
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: CustomDrawerContainer(
        label: title,
        child: Column(
          children: [
            Row(
              children: [
                CustomText.f12(
                  context,
                  dateTime != null
                      ? '${dateTime!.day} - ${DateFormat('MMMM').format(DateTime(dateTime!.year, dateTime!.month))} - ${dateTime!.year} '
                      : '${timeofDay!.hour.toString().padLeft(2, '0')} : ${timeofDay!.minute.toString().padLeft(2, '0')}',
                  weight: FontWeight.w500,
                  color: const Color.fromRGBO(24, 23, 67, 1),
                ),
                const SizedBox(
                  width: Sizes.marginV6,
                ),
                if (timeofDay != null)
                  CustomText.f10(
                    context,
                    timeofDay!.period.name,
                  ),
                const Spacer(),
                const Icon(Icons.arrow_drop_down, color: Colors.black)
              ],
            ),
            const Divider(color: Color.fromRGBO(24, 23, 67, 1)),
          ],
        ),
      ),
    );
  }
}
