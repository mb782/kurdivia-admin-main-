import 'package:flutter/material.dart';
import 'package:kurdivia_admin/Widgets/menu_item.dart';
import 'package:kurdivia_admin/constants.dart';
import 'package:kurdivia_admin/screen/m_question.dart';
import 'package:kurdivia_admin/screen/m_sponsor.dart';
import 'package:kurdivia_admin/screen/notification.dart';
import 'package:kurdivia_admin/screen/users.dart';

import '../Widgets/drawer.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text('Menu'),
        //   elevation: 0,
        //   leading: Icon(Icons.arrow_back_ios),
        //   backgroundColor: kDarkBlue,
        // ),
        endDrawer: Drawer(child: myDrawer(context)),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/2.jpg'), fit: BoxFit.cover)),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset('assets/images/pngwing.com.png'),
              ),
              menuItem(context, 'Users', (){
                kNavigator(context, Users());
              }),
              menuItem(context, 'Manage Quiz', () {
                kNavigator(context, ManageQuestion());
              }),
              // menuItem(context, 'Manage Sponsor', () {
              //   kNavigator(context, ManageSponsor());
              // }),
              // menuItem(context, 'Notification', () {
              //
              //   kNavigator(context, Notice());
              // }),

            ],
          ),
        ),
      ),
    );
  }
}
