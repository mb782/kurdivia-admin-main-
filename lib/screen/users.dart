import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kurdivia_admin/Model/user.dart';
import 'package:kurdivia_admin/screen/user_details.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../provider/ApiService.dart';

class Users extends StatefulWidget {
  Users({Key? key}) : super(key: key);

  bool visible = false;

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> implements ApiStatusLogin {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    context.read<ApiService>();
    this.context = context;
    return Consumer<ApiService>(
      builder: (context, value, child) {
        value.apiListener(this);
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey.shade300,
            actions: [
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5,horizontal: ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  //controller: value.passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: context.read<ApiService>().getAllUser(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.84,
                      child: MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: Scaffold(
                          body: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    {
                                      String val = snapshot.data!.docs[index]
                                          .get('name');
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              kNavigator(context, UserDetail(id: snapshot
                                                  .data!.docs[index]
                                                  .get('id')));
                                            },
                                            child: Row(
                                              children: [
                                                //Text((index+1).toString()+'.'),
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.white,
                                                  child: snapshot
                                                              .data!.docs[index]
                                                              .get('image')
                                                              .toString()
                                                              .length <
                                                          2
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              color: Color((math.Random()
                                                                              .nextDouble() *
                                                                          0xFFFFFF)
                                                                      .toInt())
                                                                  .withOpacity(
                                                                      0.5),
                                                              shape: BoxShape
                                                                  .circle),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.08,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                          child: Center(
                                                            child: Text(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get('name')
                                                                  .split('')
                                                                  .first,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 40,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        )
                                                      : Center(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child: Image(
                                                                image: NetworkImage(
                                                                    snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            'image')),
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                        ),
                                                ),
                                                Text(
                                                  '   ' + val,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider()
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    //;
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                        Text(snapshot.error.toString()),
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                },
              )
            ],
          ),
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
