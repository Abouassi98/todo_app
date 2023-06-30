
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../core/presentation/utils/riverpod_framework.dart';

part 'drawer_provider.g.dart';

@Riverpod(keepAlive: true)
ZoomDrawerController zoomDrawerController(ZoomDrawerControllerRef ref) =>
    ZoomDrawerController();
