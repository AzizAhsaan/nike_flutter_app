import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_app/providers/shoe_provider.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationItems = ref.watch(popularNotificationProvider);
    final notificaitoncount = ref.watch(notificationItemCountProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              ref
                  .read(popularNotificationProvider.notifier)
                  .clearNotification();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: notificationItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notificationItems[index].name),
            subtitle: Text(notificationItems[index].price.toString()),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(notificationItems[index].imageUrl),
            ),
            trailing: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  color: Colors.blueAccent[200],
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                  child: Text(
                notificaitoncount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
          );
        },
      ),
    );
  }
}
