import 'package:ntp/ntp.dart';

///
/// Retrieve time from network, fallback to local time if network is not available
///
DateTime getNetworkTime() {
  DateTime time = DateTime.now();
  NTP.now().then((value) => time = value);
  return time;
}