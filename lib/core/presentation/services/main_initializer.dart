part of '../../../main.dart';

Future<void> _mainInitializer() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  _setupLogger();

  // This Prevent closing native splash screen until we finish warming-up custom splash images.
  // App layout will be built but not displayed.
  widgetsBinding.deferFirstFrame();
  widgetsBinding.addPostFrameCallback((_) async {
    // Run any function you want to wait for before showing app layout
    final BuildContext context = widgetsBinding.rootElement!;
    await _precacheCustomSplashImages(context);

    // Closes splash screen, and show the app layout.
    widgetsBinding.allowFirstFrame();
  });
}

void _setupLogger() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((r) {
    late final String emoji;
    if (r.level == Level.WARNING) {
      emoji = '❗ ';
    } else if (r.level == Level.SEVERE) {
      emoji = '⛔️ ';
    } else {
      emoji = 'ℹ️ ';
    }
    log('$emoji[${r.loggerName}] ${r.level.name} ${r.time.toString().substring(11)}: ${r.message}');
  });
}

Future<void> _precacheCustomSplashImages(BuildContext context) async {
  await Future.wait([
    precacheImage(
      const AssetImage(MyAssets.ASSETS_IMAGES_LOGIN_LOGIN_BACKGROUND_PNG),
      context,
    ),
  ]);
}
