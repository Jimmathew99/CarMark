// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationsPage> createState() => _NotificationsPageState();
// }
//
// class _NotificationsPageState extends State<NotificationsPage> {
//   bool _messageNotifications = true;
//   bool _soundNotifications = true;
//   bool _emailNotifications = false;
//
//   // Initialize FlutterLocalNotificationsPlugin
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize settings for notifications
//     initializeNotifications();
//   }
//
//   void initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('notification_icon'); // Specify notification icon
//     final InitializationSettings initializationSettings =
//     InitializationSettings(
//         android: initializationSettingsAndroid,
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<void> showNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//         'your_channel_id', 'Your Channel Name',
//         channelDescription: 'Your channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         sound: _soundNotifications
//             ? RawResourceAndroidNotificationSound('notification_sound')
//             : null); // Replace 'notification_sound' with sound notification resource name (Android)
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'Notification Title', 'Notification Content', platformChannelSpecifics);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Notifications Settings"),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           SwitchListTile(
//             title: Text("Message Notifications"),
//             value: _messageNotifications,
//             onChanged: (value) {
//               setState(() {
//                 _messageNotifications = value;
//               });
//             },
//           ),
//           SwitchListTile(
//             title: Text("Sound Notifications"),
//             value: _soundNotifications,
//             onChanged: (value) {
//               setState(() {
//                 _soundNotifications = value;
//               });
//             },
//           ),
//           SwitchListTile(
//             title: Text("Email Notifications"),
//             value: _emailNotifications,
//             onChanged: (value) {
//               setState(() {
//                 _emailNotifications = value;
//               });
//             },
//           ),
//           TextButton(
//               onPressed: () => showNotification(), child: Text("Show Notification"))
//         ],
//       ),
//     );
//   }
// }
