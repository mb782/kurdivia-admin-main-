import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../constants.dart';
import '../provider/ApiService.dart';


class UserDetail extends StatelessWidget implements ApiStatusLogin {
  var id;

  UserDetail({Key? key,required this.id}) : super(key: key);
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
        body: SafeArea(

            child: Consumer<ApiService>(
                builder: (context, value, child) {
                  value.apiListener(this);
                  return SafeArea(
                      child:
                      FutureBuilder<
                          DocumentSnapshot>(
                        future: value.userData(id),
                        builder: (BuildContext
                        context,
                            AsyncSnapshot<
                                DocumentSnapshot>
                            snapshot) {
                          if (snapshot
                              .hasError) {
                            return const Text(
                                "Something went wrong");
                          }

                          if (snapshot
                              .hasData &&
                              !snapshot
                                  .data!
                                  .exists) {
                            return const Text(
                                "Document does not exist");
                          }

                          if (snapshot
                              .connectionState ==
                              ConnectionState
                                  .done) {
                            Map<String,
                                dynamic> data = snapshot
                                .data!
                                .data()
                            as Map<
                                String,
                                dynamic>;
                            return Column(
                              children: [

                                Center(
                                  child:  CircleAvatar(
                            radius: 70,
                              backgroundColor: Colors.white,
                              child:
                                  data['image']
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

                                child: Center(
                                  child: Text(
                                    data['name']
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
                                        data['image']),
                                      fit: BoxFit
                                          .fill),
                                ),
                              ),
                            ),
                                  ),
                                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                                Text(data['name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                Text(data['phonenumber'],style: const TextStyle(fontSize: 20),),
                                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: MediaQuery.of(context).size.height*0.4,
                                    width: MediaQuery.of(context).size.width*0.88,
                                    child:  Card(
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                         Container(
                                           margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                           child: Row(
                                             children: [
                                               Icon(Icons.location_on_outlined,color: Colors.red,),
                                               Text('Location : '),

                                               Text(data['location'])
                                             ],
                                           ),
                                         ),
                                          Divider(),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                            child: Row(
                                              children: [
                                                Icon(Icons.sensor_occupied,color: Colors.red,),
                                                SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                                                Text('occupation : '),

                                                Text(data['occupation'])
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                            child: Row(
                                              children: [
                                                Icon(Icons.event,color: Colors.red,),
                                                SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                                                Text('age : '),

                                                Text(data['age'])
                                              ],
                                            ),
                                          ),
                                          //Divider(),

                                        ],
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            );
                            // return Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     const SizedBox(
                            //       height: 10,
                            //     ),
                            //     InkWell(
                            //       onTap: (){
                            //         kNavigatorBack(context);
                            //       },
                            //       child: Container(
                            //         margin: const EdgeInsets.symmetric(horizontal: 20),
                            //         child: const CircleAvatar(
                            //           backgroundColor: kLightGreen,
                            //           child: Center(
                            //             child: Text(
                            //               'x',
                            //               style: TextStyle(fontSize: 30),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       height: 40,
                            //     ),
                            //     const Divider(
                            //       color: Colors.grey,
                            //       thickness: 2,
                            //     ),
                            //     Container(
                            //       margin: const EdgeInsets.symmetric(horizontal: 20),
                            //       child: Row(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Stack(
                            //             children: [
                            //               Container(
                            //                 child: (data['image'].toString().length>3)
                            //                     ? Container(
                            //                   height:MediaQuery.of(context).size.height*0.09 ,
                            //                   width:MediaQuery.of(context).size.width*0.17 ,
                            //                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                            //                   child: ClipRRect(
                            //                       borderRadius: BorderRadius
                            //                           .circular(
                            //                           40),
                            //                       child: Image
                            //                           .network(
                            //                         data['image'],
                            //                         fit: BoxFit
                            //                             .fill,)),
                            //                 )
                            //                     :const CircleAvatar(
                            //                   child: const Icon(Icons.person),
                            //                   radius: 40,
                            //                 ),
                            //               ),
                            //               Positioned(
                            //                 right: 0,
                            //                 bottom: 0,
                            //                 child: CircleAvatar(
                            //                   radius: 12,
                            //                   backgroundColor: kLightGreen,
                            //                   child: InkWell(
                            //                     onTap: () async {
                            //
                            //                     },
                            //                     child: const Icon(
                            //                       Icons.edit,
                            //                       size: 15,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //           Container(
                            //             margin: const EdgeInsets.symmetric(
                            //                 horizontal: 20, vertical: 10),
                            //             child: Column(
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children:  [
                            //                 Text(
                            //                   data['name'],
                            //                   style: const TextStyle(
                            //                       color: kLightGreen,
                            //                       fontSize: 20,
                            //                       fontWeight: FontWeight.w900,
                            //                       fontFamily: 'Mont'),
                            //                 ),
                            //                 const SizedBox(
                            //                   height: 10,
                            //                 ),
                            //                 Text(
                            //                   data['apartment'],
                            //                   style: const TextStyle(
                            //                       color: kDarkBlue,
                            //                       fontFamily: 'Mont',
                            //                       fontWeight: FontWeight.w900),
                            //                 ),
                            //                 Text(
                            //                   'Number :${data['unit']}',
                            //                   style: const TextStyle(
                            //                       color: kDarkBlue,
                            //                       fontFamily: 'Mont',
                            //                       fontWeight: FontWeight.w900),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     const Divider(
                            //       color: Colors.grey,
                            //       thickness: 2,
                            //     ),
                            //     const SizedBox(
                            //       height: 10,
                            //     ),
                            //     // Expanded(
                            //     //   child: ListView(
                            //     //     padding: const EdgeInsets.symmetric(horizontal: 20),
                            //     //     children: [
                            //     //       profileOptions(FontAwesomeIcons.briefcase, 'My Posts', () {
                            //     //         kNavigator(context, Posts());
                            //     //       }),
                            //     //       profileOptions(Icons.settings, 'Settings', () {
                            //     //         kNavigator(context, SettingPage());
                            //     //       }),
                            //     //       profileOptions(Icons.announcement_outlined, 'Legal', () {
                            //     //         kNavigator(context, Legal());
                            //     //       }),
                            //     //       Container(
                            //     //           child: (data['admin']=='true')
                            //     //               ?Column(
                            //     //             children: [
                            //     //               profileOptions(Icons.add_business_sharp, 'add your apartment', () {
                            //     //                 kNavigator(context, SelectCountry(previusScreen: 'profile'));
                            //     //               }),
                            //     //               profileOptions(Icons.send_and_archive, 'send notice', () {
                            //     //                 showDialog<
                            //     //                     String>(
                            //     //                     context:
                            //     //                     context,
                            //     //                     builder:
                            //     //                         (BuildContext
                            //     //                     context) {
                            //     //                       return Dialog(
                            //     //                         child: SendNoticeDialog(userEmail: data['email'],uid:myId,name: data['name'], ),
                            //     //                       );
                            //     //                     });
                            //     //               }),
                            //     //             ],
                            //     //           )
                            //     //               :Container()
                            //     //       ),
                            //     //       profileOptions(FontAwesomeIcons.signOutAlt, 'Logout', () {
                            //     //         value.signOut(context);
                            //     //       }),
                            //     //       Container(
                            //     //           child: (data['admin']=='false')
                            //     //               ?profileOptions(Icons.send, 'admin request', () {
                            //     //             showDialog<
                            //     //                 String>(
                            //     //                 context:
                            //     //                 context,
                            //     //                 builder:
                            //     //                     (BuildContext
                            //     //                 context) {
                            //     //                   return Dialog(
                            //     //                     child: EmailDialog(userEmail: data['email'],uid:myId,name: data['name'], ),
                            //     //                   );
                            //     //                 });
                            //     //           })
                            //     //               :Container()
                            //     //       ),
                            //     //
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //   ],
                            // );
                          }

                          return const Center(
                            child: Text(
                              "loading...",style: TextStyle(color: kLightGreen,fontSize: 20,fontFamily: 'Mont'),),
                          );
                        },
                      )
                  );
                }))
    );
  }

  @override
  void accountAvailable() {

  }

  @override
  void error() {
    ModeSnackBar.show(context, 'something go wrong', SnackBarMode.error);
  }

  @override
  void inputEmpty() {
    ModeSnackBar.show(context, 'username or password empty', SnackBarMode.warning);
  }

  @override
  void inputWrong() {
    ModeSnackBar.show(context, 'username or password incorrect', SnackBarMode.warning);
  }

  @override
  void login(){
    //Box b = Hive.box('vet');
    //b.put('vet', false);
    kNavigatorBack(context);

  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }


profileOptions(icon, text,onPressed) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      InkWell(
        onTap:onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: kLightGreen,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: kLightGreen,
                  fontFamily: 'Mont',
                  fontWeight: FontWeight.w900,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    ],
  );
}

  @override
  void inputnotfill() {
    // TODO: implement inputnotfill
  }}
