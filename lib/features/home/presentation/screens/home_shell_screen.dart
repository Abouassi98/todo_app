import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../../../auth/presentation/providers/sign_out_provider.dart';
import '../../../../core/core_features/theme/presentation/utils/colors/app_static_colors.dart';
import '../../../../core/presentation/extensions/responsive_extensions.dart';
import '../../../../core/presentation/screens/full_screen_platfom_scaffold.dart';
import '../../../../core/presentation/services/connection_stream_service.dart';

import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/utils/toasts.dart';
import '../../../../core/presentation/widgets/bottom_to_top_animation_view.dart';

import '../components/drawer_component.dart';
import '../components/drawer_update_component.dart';
import '../components/todo_component.dart';
import '../provider/drawer_provider.dart';
import '../provider/selected_item_provider.dart';

class HomeShellScreen extends HookConsumerWidget {
  const HomeShellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectedItemProvider);
    final controller =
        useMemoized(() => ref.read(zoomDrawerControllerProvider));
    ref.listen(connectionStreamProvider, (prevState, newState) {
      newState.whenOrNull(
        data: (status) {
          Toasts.showConnectionToast(context, connectionStatus: status);
        },
      );
    });

    ref.easyListen(signOutStateProvider);

    return WillPopScope(
      onWillPop: () async {
        if (controller.isOpen!()) {
          await controller.close!();
          return false;
        }
        return true;
      },
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppStaticColors.homeIngredientColor,
            ),
          ),
          BottomToTopAnimationView(
            child: FullScreenPlatformScaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: AppStaticColors.homeIngredientColor,
                ),
                child: ZoomDrawer(
                  borderRadius: 24,
                  mainScreenTapClose: true,
                  isRtl: true,
                  angle: 0,
                  menuScreenWidth: context.width * 0.7,
                  mainScreen: const ToDoComponent(),
                  menuScreen: selectedItem.isNone()
                      ? const CustomDrawer()
                      : CustomUpdateDrawer(
                          key: UniqueKey(),
                          todoItem: selectedItem.toNullable()!,
                        ),
                  disableDragGesture: true,
                  controller: controller,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
