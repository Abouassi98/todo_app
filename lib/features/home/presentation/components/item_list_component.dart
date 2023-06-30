import 'package:flutter/material.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import '../../../../core/presentation/widgets/seperated_sliver_child_builder_delegate.dart';
import '../../domain/entity/todo.dart';
import '../widgets/todo_item.dart';

class ItemListComponent extends HookConsumerWidget {
  const ItemListComponent({
    required this.items,

    super.key,
  });
  final List<Todo> items;
 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    );
    final animation = useMemoized(
      () => CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    useEffect(() {
      animationController.forward();
      return null;
    });
    return items.isNotEmpty
        ? SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.screenMarginV8,
              horizontal: Sizes.screenMarginH20,
            ),
            sliver: SliverList(
              delegate: SeparatedSliverChildBuilderDelegate(
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return FadeTransition(
                    opacity: animation,
                    child: TodoItem(
                      todoItem: items[i],
                
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: Sizes.marginV20,
                  );
                },
              ),
            ),
          )
        : SliverFillRemaining(
            child: Center(
              child: CustomText.f18(
                context,
                'there Are No Items',
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
