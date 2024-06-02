import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  //to initialize notification
  static init() {
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher')));
    tz.initializeTimeZones();
  }

  //to trigger notification
  static Future<void> scheduleNotification(BuildContext context, String title,
      String body, Function(String) timeSelected) async {
    //to set time
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (pickedTime != null) {
      final now = tz.TZDateTime.now(tz.local);
      final selectedTime = tz.TZDateTime(tz.local, now.year, now.month, now.day,
          pickedTime.hour, pickedTime.minute);

      if (selectedTime.isBefore(now)) {
        selectedTime.add(const Duration(days: 1));
      }

      //setting the details of notification
      //importance and priority are given max and high cause it should be displayed on time no matter what
      var details = const AndroidNotificationDetails(
          'important_notification', 'My Channel',
          importance: Importance.max, priority: Priority.high);

      var notificationDetails = NotificationDetails(android: details);

      await _notification.zonedSchedule(1, title, body,
          selectedTime, notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);

      final nowDateTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      final formattedTime = DateFormat('hh:mm a').format(nowDateTime);
      timeSelected(formattedTime);
    }
  }
}
