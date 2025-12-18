import 'package:logging/logging.dart';
import 'package:ntp/ntp.dart';

class TimeUtils {
  static final Logger _log = Logger('TimeUtils');

  ///
  /// Retrieve time from network, fallback to local time if network is not available
  ///
  Future<DateTime> tryGetNetworkTime() async {
    DateTime time = DateTime.now();
    try {
      time = await NTP.now();
    } on Exception catch (e) {
      _log.warning('Could not retrieve time from network', e);
    }
    return time;
  }
}
