import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:kurdivia_admin/Model/user.dart';
import 'package:kurdivia_admin/screen/user_details.dart';
import 'package:provider/provider.dart';

import '../Widgets/drawer.dart';
import '../Widgets/my_dialog.dart';
import '../constants.dart';
import '../provider/ApiService.dart';


class MyDialog extends StatefulWidget {
  var id;

  MyDialog({Key? key,required this.id}) : super(key: key);

  bool visible = false;

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> implements ApiStatusLogin {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    context.read<ApiService>();
    this.context = context;
    return Consumer<ApiService>(
      builder: (context, value, child) {
        value.apiListener(this);
        return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40)),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: kLightGreen,
                      borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller:value.newTitleController ,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "write your new title",
                        hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {
                    if(value.newTitleController.text.isNotEmpty){
                      value.updateEvents(widget.id);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: kButtonBlue,
                        borderRadius: BorderRadius.circular(20)),
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Center(child: Text('save',style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ],
            ));
      },
    );
  }

  @override
  void inputEmpty() {
    ModeSnackBar.show(
        context, 'username or password empty', SnackBarMode.warning);
  }

  @override
  void inputWrong() {
    ModeSnackBar.show(
        context, 'username or password incorrect', SnackBarMode.warning);
  }

  @override
  void login() {}

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }

  @override
  void accountAvailable() {
    // TODO: implement accountAvailable
  }

  @override
  void error() {
    ModeSnackBar.show(context, 'something go wrong', SnackBarMode.error);
  }

  @override
  void inputnotfill() {
    // TODO: implement inputnotfill
  }
}
