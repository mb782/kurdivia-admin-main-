import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:kurdivia_admin/Model/user.dart';
import 'package:kurdivia_admin/Widgets/delet_dialog.dart';
import 'package:kurdivia_admin/screen/m_sponsor.dart';
import 'package:kurdivia_admin/screen/sponsor_details.dart';
import 'package:kurdivia_admin/screen/user_details.dart';
import 'package:provider/provider.dart';

import '../Widgets/drawer.dart';
import '../Widgets/my_dialog.dart';
import '../constants.dart';
import '../provider/ApiService.dart';
import 'add_question.dart';

class QuestionDetails extends StatefulWidget {
  var id;

  QuestionDetails({Key? key, required this.id}) : super(key: key);

  bool visible = false;

  @override
  State<QuestionDetails> createState() => _QuestionDetailsState();
}

class _QuestionDetailsState extends State<QuestionDetails>
    implements ApiStatusLogin {
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
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    kNavigator(context, AddQuestion(id: widget.id));
                    // _controller.jumpToDate(DateTime.now());
                    // setState(() {});
                  },
                  child: const Icon(Icons.add),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      // Container(
                      //     height: 110,
                      //     decoration: const BoxDecoration(
                      //       color: Colors.blue,
                      //       //     boxShadow: [
                      //       //   // BoxShadow(
                      //       //   //     color: Colors.black.withOpacity(0.2),
                      //       //   //     blurRadius: 10,
                      //       //   //     spreadRadius: 1)
                      //       // ]
                      //     ),
                      //     child: CalendarWeek(
                      //       backgroundColor: Colors.blue,
                      //       dayOfWeekStyle:
                      //           const TextStyle(color: Colors.white),
                      //       weekendsStyle: const TextStyle(color: Colors.white),
                      //       todayDateStyle: const TextStyle(color: Colors.blue),
                      //       todayBackgroundColor: Colors.white,
                      //       dateStyle: const TextStyle(color: Colors.white),
                      //       //controller: _controller,
                      //       height: 100,
                      //       showMonth: true,
                      //       minDate: DateTime.now().add(
                      //         const Duration(days: -365),
                      //       ),
                      //       maxDate: DateTime.now().add(
                      //         const Duration(days: 365),
                      //       ),
                      //       onDatePressed: (DateTime datetime) {
                      //         // Do something
                      //         setState(() {});
                      //       },
                      //       onDateLongPressed: (DateTime datetime) {
                      //         // Do something
                      //       },
                      //       onWeekChanged: () {
                      //         // Do something
                      //       },
                      //       monthViewBuilder: (DateTime time) => Align(
                      //         alignment: FractionalOffset.center,
                      //         child: Container(
                      //             margin:
                      //                 const EdgeInsets.symmetric(vertical: 4),
                      //             child: Text(
                      //               DateFormat.MMMM().format(time),
                      //               overflow: TextOverflow.ellipsis,
                      //               textAlign: TextAlign.center,
                      //               style: const TextStyle(
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.w600,
                      //                   fontSize: 15),
                      //             )),
                      //       ),
                      //     )),
                      StreamBuilder<QuerySnapshot>(
                        stream: context
                            .read<ApiService>()
                            .getQuestionDetails(widget.id),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              height: MediaQuery.of(context).size.height * 0.89,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        {
                                          return Stack(
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.4,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.9,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Container(
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.2),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Text(
                                                                      'Question : ' +
                                                                          snapshot.data!.docs[index].get(
                                                                              'question'),
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  Text(
                                                                      'Answer : ' +
                                                                          snapshot.data!.docs[index].get(
                                                                              'answer'),
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  Text(
                                                                      'a : ' +
                                                                          snapshot.data!.docs[index].get(
                                                                              'a'),
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  Text(
                                                                      'b : ${snapshot.data!.docs[index].get('b')}',
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  Text(
                                                                      'c : ' +
                                                                          snapshot.data!.docs[index].get(
                                                                              'c'),
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  Text(
                                                                      'time : ${snapshot.data!.docs[index].get('time')}',
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  (snapshot.data!.docs[index]
                                                                              .get(
                                                                                  'image')
                                                                              .toString()
                                                                              .length >
                                                                          5)
                                                                      ? Image.network(snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .get(
                                                                              'image'))
                                                                      : Image.asset(
                                                                          'assets/images/adap.png')
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                                top: -13,
                                                  right: 5,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        value.deleteQuestionDetails(widget.id, snapshot.data!.docs[index].id);
                                                        print(snapshot.data!.docs[index].id);
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      )))
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                            //;
                          } else if (snapshot.hasError) {
                            return Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
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
                    ]),
                  ),
                ),
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Question Details'),
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      kNavigatorBack(context);
                    },
                  ),
                  backgroundColor: Colors.blue,
                ),
                // endDrawer: Drawer(child: myDrawer(context))
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
