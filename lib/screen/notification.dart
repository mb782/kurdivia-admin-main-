import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kurdivia_admin/constants.dart';

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/2.jpg',
                ),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Notification',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.8),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          //controller:value.sendNoticeTitleController ,
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
                              hintText: "write your message...",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {},
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                )
                              ],
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(20)),
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Center(child: Text('Send',style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
