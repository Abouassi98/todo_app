import 'package:flutter/cupertino.dart';
import 'platform_widgets/custom_show_bottom_sheet.dart';

import '../../../features/home/presentation/provider/filter_item_provider.dart';
import '../../../features/home/presentation/widgets/drawer_colors_item.dart';
import '../../../features/home/presentation/widgets/drawr_date.dart';
import '../../core_features/theme/presentation/utils/colors/app_static_colors.dart';
import '../routing/navigation_service.dart';
import '../styles/sizes.dart';
import '../utils/fp_framework.dart';
import '../utils/riverpod_framework.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CustomBottomSheet extends ConsumerWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(filterDateItemProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingH14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomText.f20(
            context,
            'FILTER',
            color: AppStaticColors.blue,
            weight: FontWeight.normal,
          ),
          const DrawerColorsItem(isBottomShhet: true),
          DrawerDateItem(
            onTap: () async {
              await NavigationService.pop<void>(context).whenComplete(
                () => showPlatformDatePicker<void>(context: context)
                    .then((value) {
                  if (value != null) {
                    ref.watch(filterDateItemProvider.notifier).update(
                          (state) =>
                              state = Some(value.toString().substring(0, 10)),
                        );
                  }
                }),
              );
            },
            dateTime: DateTime(
              int.parse(date.toNullable()?.substring(0, 4) ?? '2023'),
              int.parse(date.toNullable()?.substring(5, 7) ?? '9'),
              int.parse(date.toNullable()?.substring(8, 10) ?? '23'),
            ),
            title: 'Date',
          ),
          CustomButton(
            onPressed: () {
              NavigationService.pop<int>(context);
              ref.read(clearFilterDateAndColorProvider);
            },
            text: 'clear',
          ),
        ],
      ),
    );
  }
}
