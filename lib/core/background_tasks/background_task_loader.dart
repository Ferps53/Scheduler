import 'package:flutter_background_service/flutter_background_service.dart';

class BackgroundTaskLoader {
  static Future<void> initializeServices() async {
    final service = FlutterBackgroundService();
    await service.configure(
      iosConfiguration: IosConfiguration(
        onForeground: _onStart,
        autoStart: true,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        isForegroundMode: true,
      ),
    );
  }

  @pragma('vm:entry-point')
  static void _onStart(ServiceInstance service) async {
    //TODO add all services to be ran in background
  }
}
