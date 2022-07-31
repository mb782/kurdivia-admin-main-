import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../screen/notification.dart';

myDrawer(context){
  return ListView(
      children: <Widget>[

        Container (
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.notifications_active),
                  title: Text('Notification'),
                  onTap: (){kNavigator(context, Notice());},
                ),
                ListTile(
                  leading: Icon(Icons.notifications_active),
                  title: Text('main'),
                )
              ],
            )
        )]);
}