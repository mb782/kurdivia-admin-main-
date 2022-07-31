import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:expandable/expandable.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:kurdivia_admin/Model/user.dart';
import 'package:kurdivia_admin/Widgets/delet_dialog.dart';
import 'package:kurdivia_admin/screen/m_sponsor.dart';
import 'package:kurdivia_admin/screen/question_details.dart';
import 'package:kurdivia_admin/screen/sponsor_details.dart';
import 'package:kurdivia_admin/screen/user_details.dart';
import 'package:kurdivia_admin/screen/usersandwinner.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../Widgets/drawer.dart';
import '../Widgets/my_dialog.dart';
import '../Widgets/video_player_widget.dart';
import '../constants.dart';
import '../provider/ApiService.dart';
import 'add_question.dart';

class ManageQuestion extends StatefulWidget {
  ManageQuestion({Key? key}) : super(key: key);

  bool visible = false;

  @override
  State<ManageQuestion> createState() => _ManageQuestionState();
}

class _ManageQuestionState extends State<ManageQuestion> implements ApiStatusLogin {
  late BuildContext context;

  late VideoPlayerController controller;


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
                    kNavigator(context, ManageSponsor());
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
                      //       dayOfWeekStyle: const TextStyle(color: Colors.white),
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
                      //             margin: const EdgeInsets.symmetric(vertical: 4),
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
                        stream: context.read<ApiService>().getAllEvents(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 7),
                              height: MediaQuery.of(context).size.height*0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: RefreshIndicator(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index){
                                            String title = snapshot.data!.docs[index]
                                                .get('title');

                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                     Text((index+1).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                    Container(
                                                      height: MediaQuery.of(context).size.height * 0.12,
                                                      width: MediaQuery.of(context).size.width * 0.8,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey.shade300,
                                                          border: Border.all(color:value.iscoming
                                                              ? kLightBlue : Colors.red,width: 3),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.6),
                                                              blurRadius: 20,
                                                              offset: Offset(3, 5),
                                                            )
                                                          ],
                                                          borderRadius: BorderRadius.circular(10)),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                              margin: const EdgeInsets.symmetric(
                                                                  horizontal: 20, vertical: 5),
                                                              child:  Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                                            alignment: Alignment.center,
                                                          ),
                                                          Row(
                                                            children:  [
                                                              const Spacer(
                                                                flex: 3,
                                                              ),
                                                              IconButton(onPressed:  () {
                                                                showDialog<
                                                                    String>(
                                                                    context:
                                                                    context,
                                                                    builder:
                                                                        (BuildContext
                                                                    context) {
                                                                      return AlertDialog(
                                                                        shape: RoundedRectangleBorder(borderRadius:
                                                                        BorderRadius.all(Radius.circular(40))),
                                                                        //title: Text('Your title!'),
                                                                        content: MyDialog(id: snapshot.data?.docs[index].id,),
                                                                      );
                                                                    });
                                                              }, icon:Container(
                                                                child: Image(image: AssetImage('assets/images/edit.png')),
                                                              ),),

                                                              const Spacer(
                                                                flex: 1,
                                                              ),
                                                              IconButton(onPressed: () {
                                                                showDialog<
                                                                    String>(
                                                                    context:
                                                                    context,
                                                                    builder:
                                                                        (BuildContext
                                                                    context) {
                                                                      return AlertDialog(
                                                                        shape: RoundedRectangleBorder(borderRadius:
                                                                        BorderRadius.all(Radius.circular(40))),
                                                                        //title: Text('Your title!'),
                                                                        content: DeleteDialog(id: snapshot.data?.docs[index].id,),
                                                                      );
                                                                    });
                                                              }, icon: Container(
                                                                child: Image(image: AssetImage('assets/images/delete.png')),
                                                              ),),
                                                              const Spacer(
                                                                flex: 1,
                                                              ),
                                                              InkWell(
                                                                onTap: (){
                                                                  kNavigator(context, UsersAndWnner(id: snapshot.data!.docs[index].id));
                                                                },
                                                                child: Container(
                                                                  child: Icon(Icons.supervised_user_circle,color: kDarkBlue,),
                                                                ),
                                                              ),
                                                              const Spacer(
                                                                flex: 3,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    IconButton(onPressed: (){
                                                      kNavigator(context, QuestionDetails(id: snapshot.data?.docs[index].id));

                                                      print(snapshot.data?.docs[index].id);
                                                    }, icon: Icon(Icons.double_arrow_rounded))
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ExpandablePanel(header:Container(padding: EdgeInsets.only(top: 10),child: Center(child: Text('Detail',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))) ,collapsed: Text(''), expanded:
                                                StreamBuilder<QuerySnapshot>(
                                                  stream: context
                                                      .read<ApiService>()
                                                      .getSponsorDetails(snapshot.data?.docs[index].id),
                                                  builder: (BuildContext context,
                                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                                    if (snapshot.hasData) {
                                                      return SingleChildScrollView(
                                                        child: Container(
                                                          margin: EdgeInsets.only(top: 10),
                                                          height: MediaQuery.of(context).size.height * 0.65,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Expanded(
                                                                child: ListView.builder(
                                                                  shrinkWrap: true,
                                                                  itemCount: snapshot.data!.docs.length,
                                                                  itemBuilder: (context, index) {
                                                                    {
                                                                      String title = snapshot
                                                                          .data!.docs[index]
                                                                          .get('title');
                                                                      Timestamp date = snapshot
                                                                          .data!.docs[index]
                                                                          .get('date');
                                                                      if(snapshot.data!.docs[index].get('file') == false){
                                                                        controller = VideoPlayerController.network(snapshot.data!.docs[index].get('image'))
                                                                          ..addListener(() {})
                                                                          ..setLooping(false)
                                                                          ..initialize().then((_) {
                                                                            controller.pause();
                                                                            value.notifyListeners();
                                                                          });
                                                                      }
                                                                      return Column(
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
                                                                                        0.6,
                                                                                    width: MediaQuery.of(
                                                                                        context)
                                                                                        .size
                                                                                        .width *
                                                                                        0.9,
                                                                                    decoration: BoxDecoration(
                                                                                        color: Colors
                                                                                            .grey.shade300,
                                                                                        borderRadius:
                                                                                        BorderRadius
                                                                                            .circular(
                                                                                            10),
                                                                                      boxShadow: [
                                                                                        BoxShadow(
                                                                                          color: Colors.black.withOpacity(0.6),
                                                                                          blurRadius: 20,
                                                                                          offset: Offset(0, 10),
                                                                                        )
                                                                                      ],
                                                                                    ),


                                                                                    child: Container(
                                                                                      margin: EdgeInsets.symmetric(
                                                                                          horizontal:
                                                                                          MediaQuery.of(
                                                                                              context)
                                                                                              .size
                                                                                              .width *
                                                                                              0.01),
                                                                                      child: Column(
                                                                                        crossAxisAlignment:
                                                                                        CrossAxisAlignment
                                                                                            .center,
                                                                                        mainAxisAlignment:
                                                                                        MainAxisAlignment
                                                                                            .spaceEvenly,
                                                                                        children: [
                                                                                          Text(
                                                                                              'Title : ' +
                                                                                                  title,
                                                                                              style: const TextStyle(
                                                                                                  fontWeight:
                                                                                                  FontWeight
                                                                                                      .bold)),
                                                                                          Text(
                                                                                              'description : ' +
                                                                                                  snapshot
                                                                                                      .data!
                                                                                                      .docs[
                                                                                                  index]
                                                                                                      .get(
                                                                                                      'description'),
                                                                                              style: const TextStyle(
                                                                                                  fontWeight:
                                                                                                  FontWeight
                                                                                                      .bold)),
                                                                                          Row(
                                                                                            mainAxisAlignment:
                                                                                            MainAxisAlignment
                                                                                                .center,
                                                                                            children: [
                                                                                              Text(
                                                                                                'date : ' +
                                                                                                    date
                                                                                                        .toDate()
                                                                                                        .year
                                                                                                        .toString() +
                                                                                                    '/',
                                                                                                style: const TextStyle(
                                                                                                    fontWeight:
                                                                                                    FontWeight.bold),
                                                                                              ),
                                                                                              Text(
                                                                                                  date.toDate().month.toString() +
                                                                                                      '/',
                                                                                                  style: const TextStyle(
                                                                                                      fontWeight:
                                                                                                      FontWeight.bold)),
                                                                                              Text(
                                                                                                  date.toDate().day.toString() +
                                                                                                      '   ',
                                                                                                  style: const TextStyle(
                                                                                                      fontWeight:
                                                                                                      FontWeight.bold)),
                                                                                              Text(
                                                                                                  date.toDate().hour.toString() +
                                                                                                      ':',
                                                                                                  style: const TextStyle(
                                                                                                      fontWeight:
                                                                                                      FontWeight.bold)),
                                                                                              Text(
                                                                                                date
                                                                                                    .toDate()
                                                                                                    .minute
                                                                                                    .toString() +
                                                                                                    ':',
                                                                                                style: const TextStyle(
                                                                                                    fontWeight:
                                                                                                    FontWeight.bold),
                                                                                              ),
                                                                                              Text(
                                                                                                  date
                                                                                                      .toDate()
                                                                                                      .second
                                                                                                      .toString(),
                                                                                                  style: const TextStyle(
                                                                                                      fontWeight:
                                                                                                      FontWeight.bold)),
                                                                                            ],
                                                                                          ),
                                                                                          Text(
                                                                                              'link : ' +
                                                                                                  snapshot
                                                                                                      .data!
                                                                                                      .docs[
                                                                                                  index]
                                                                                                      .get(
                                                                                                      'link'),
                                                                                              style: const TextStyle(
                                                                                                  fontWeight:
                                                                                                  FontWeight
                                                                                                      .bold)),
                                                                                          // Text(
                                                                                          //     'number of users : ' +
                                                                                          //         snapshot
                                                                                          //             .data!
                                                                                          //             .docs[
                                                                                          //                 index]
                                                                                          //             .get(
                                                                                          //                 'numusers')
                                                                                          //             .toString(),
                                                                                          //     style: const TextStyle(
                                                                                          //         fontWeight:
                                                                                          //             FontWeight
                                                                                          //                 .bold)),
                                                                                          Text(
                                                                                              'number of winners : ' +
                                                                                                  snapshot
                                                                                                      .data!
                                                                                                      .docs[
                                                                                                  index]
                                                                                                      .get(
                                                                                                      'numwinner'),
                                                                                              style: const TextStyle(
                                                                                                  fontWeight:
                                                                                                  FontWeight
                                                                                                      .bold)),
                                                                                          Text(
                                                                                              'opprice : ' +
                                                                                                  snapshot
                                                                                                      .data!
                                                                                                      .docs[
                                                                                                  index]
                                                                                                      .get(
                                                                                                      'opprice'),
                                                                                              style: const TextStyle(
                                                                                                  fontWeight:
                                                                                                  FontWeight
                                                                                                      .bold)),
                                                                                          Text(
                                                                                              'price : ' +
                                                                                                  snapshot
                                                                                                      .data!
                                                                                                      .docs[
                                                                                                  index]
                                                                                                      .get(
                                                                                                      'price'),
                                                                                              style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                                          Text(
                                                                                              'media : ' +
                                                                                                  snapshot
                                                                                                      .data!
                                                                                                      .docs[
                                                                                                  index]
                                                                                                      .get(
                                                                                                      'image'),
                                                                                              style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                                          // (snapshot.data!.docs[index].get('image').toString().length > 5)
                                                                                          // ?snapshot.data!.docs[index].get('file') == false
                                                                                          // ?Stack(children: [ClipRRect(borderRadius: BorderRadius.circular(15),child: VideoPlayerWidget(controller: controller))],)
                                                                                          //     : Image.network(snapshot.data!.docs[index].get('image'),height: 250,width: double.infinity,)
                                                                                          //     : Image.asset('assets/images/adap.png')
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  // Row(
                                                                                  //   children: [
                                                                                  //     IconButton(
                                                                                  //         onPressed: () {
                                                                                  //           kNavigatorBack(
                                                                                  //               context);
                                                                                  //         },
                                                                                  //         icon: const Icon(
                                                                                  //           Icons
                                                                                  //               .rotate_left_outlined,
                                                                                  //           size: 50,
                                                                                  //           color:
                                                                                  //           Colors.red,
                                                                                  //         )),
                                                                                  //     IconButton(
                                                                                  //         onPressed: () {
                                                                                  //
                                                                                  //         },
                                                                                  //         icon: const Icon(
                                                                                  //           Icons
                                                                                  //               .rotate_right_outlined,
                                                                                  //           size: 50,
                                                                                  //           color: Colors
                                                                                  //               .lightGreenAccent,
                                                                                  //         ))
                                                                                  //   ],
                                                                                  // ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 30,
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                                ),
                                                )
                                              ],
                                            );

                                        },
                                      ),
                                      onRefresh: ()async{
                                        value.notifyListeners();
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
                    ]),
                  ),
                ),
                appBar: AppBar(

                  centerTitle: true,
                  title: const Text('Main'),
                  elevation: 0,
                  leading: IconButton(icon:  Icon(Icons.arrow_back_ios),onPressed: (){
                    kNavigatorBack(context);
                  },),
                  backgroundColor: Colors.blue,
                ),

                // endDrawer:  Drawer(
                //     child:  myDrawer(context))
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
