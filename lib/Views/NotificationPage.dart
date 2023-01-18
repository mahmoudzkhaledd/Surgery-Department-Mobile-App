import 'package:flutter/material.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'package:surgery/Services/DoctorServices.dart';

import '../Model/Notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.id,required this.type}) : super(key: key);
  final int id;
  final int type;
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  List<MyNotification> notifications = <MyNotification>[];
  @override
  void initState() {
    loadNotifications();
    super.initState();
  }
  void deleteNotification(int index)async {
    await DoctorServices.deleteNotification(notifications[index].id);
    loadNotifications();
  }
  void loadNotifications() async {
    notifications.clear();
    var x = await Services.loadNotifications(widget.id);
    for (Map<String, dynamic> i in x) {
      notifications.add(MyNotification.getNotification(i));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Your Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          loadNotifications();
        },
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (BuildContext context, int index) {
            return NotifivationObj(
              notification: notifications[index],
              onTap: ()async{
                deleteNotification(index);
              },
            );
          },
        ),
      ),
    );
  }


}

class NotifivationObj extends StatelessWidget {
  const NotifivationObj(
      {Key? key, required this.notification, required this.onTap})
      : super(key: key);
  final MyNotification notification;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.from,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    notification.content,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.clear),
          )
        ],
      ),
    );
  }
}
