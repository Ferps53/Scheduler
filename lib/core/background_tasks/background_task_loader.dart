import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:scheduler/core/background_tasks/table_sync/table_sync.dart';
import 'package:scheduler/core/core.dart';

class BackgroundTaskLoader {
  const BackgroundTaskLoader();

  static Future<void> initializeServices() async {
    print('Initializing services');
    final service = FlutterBackgroundService();

    print('Created service');

    await service.configure(
      iosConfiguration: IosConfiguration(
        onForeground: _onStart,
        autoStart: true,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        isForegroundMode: true,
        autoStart: false,
      ),
    );
  }

  @pragma('vm:entry-point')
  static void _onStart(ServiceInstance service) {
    final onStatusChange = InternetConnection().onStatusChange;

    onStatusChange.listen((InternetStatus status) async {
      if (status == InternetStatus.connected) {
        // await tableSync.synchronizeDatabase();
      }
    });
  }
}
