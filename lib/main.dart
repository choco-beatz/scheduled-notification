import 'package:flutter/material.dart';
import 'package:notification_app/constant/color.dart';
import 'package:notification_app/notification_helper.dart';
import 'package:notification_app/widget/cards.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper.init();
// Request notification and exact alarm permissions
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  if (await Permission.scheduleExactAlarm.isDenied) {
    await Permission.scheduleExactAlarm.request();
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String bTime = '00:00';
  String lTime = '00:00';
  String dTime = '00:00';

  void _updatedTime(String meal, String time) {
    setState(() {
      if (meal == 'BREAKFAST') {
        bTime = time;
      } else if (meal == 'LUNCH') {
        lTime = time;
      } else if (meal == 'DINNER') {
        dTime = time;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bg,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  NotificationHelper.scheduleNotification(
                      context, 'BREAKFAST', 'Time for breakfast',
                      (time) => _updatedTime('BREAKFAST', time));
                },
                child: Cards(
                  text: 'BREAKFAST', time: bTime,
                )),
            GestureDetector(
                onTap: () {
                  NotificationHelper.scheduleNotification(
                      context, 'LUNCH', 'Time for lunch',
                      (time) => _updatedTime('LUNCH', time));
                },
                child: Cards(
                  text: 'LUNCH', time: lTime,
                )),
            GestureDetector(
                onTap: () {
                  NotificationHelper.scheduleNotification(
                      context, 'DINNER', 'Time for dinner',
                      (time) => _updatedTime('DINNER', time));
                },
                child: Cards(
                  text: 'DINNER', time: dTime,
                ))
          ],
        )
        // FilledButton(
        //     onPressed: () {
        //       NotificationHelper.scheduleNotification(
        //          context, 'Scheduled', 'This is scheduled notification');
        //     },
        //     child: const Text('Breakfast'))

        );
  }
}
