import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kurdivia_admin/screen/user_details.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../constants.dart';
import '../provider/ApiService.dart';

class UsersAndWnner extends StatelessWidget implements ApiStatusLogin {
  UsersAndWnner({required this.id});
  String id;

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    context.read<ApiService>();
    return Consumer<ApiService>(
        builder: (context, value, child) {
      value.apiListener(this);
      return SafeArea(child: Scaffold(
        body:   Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              SizedBox(height: 20,),
              Text('Winners :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   child: Text(
                  //     'WINNERS ',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold, fontSize: 15),
                  //   ),
                  //
                  // ),
                  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: context.read<ApiService>().getAllwinner(id),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot<
                              Map<String, dynamic>>> snapshot) {
                        if (snapshot.hasData) {
                          List list = snapshot.data!.get('winner');
                          return Container(
                            height: 200,
                            child: ListView.builder(
                                itemCount: list.length,

                                itemBuilder: (context,index){
                                  return InkWell(
                                    onTap: (){
                                      kNavigator(context, UserDetail(id: list[index]));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 5),
                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                        height: 75,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.8,
                                        decoration: BoxDecoration(
                                            color: kLightBlue,
                                            borderRadius: BorderRadius.circular(30)),
                                        child: getwinnerdetail(list[index])),
                                  );
                                }),
                          );
                        }
                        return Center(
                            child: const CircularProgressIndicator(
                              color: Colors.black,
                              backgroundColor: Colors.white,));
                      }),
                  ListView(
                    shrinkWrap: true,
                    children: const[

                      // Container(
                      //     height: 75,
                      //     width: MediaQuery
                      //         .of(context)
                      //         .size
                      //         .width * 0.8,
                      //     decoration: BoxDecoration(
                      //         color: Colors.pinkAccent,
                      //         borderRadius: BorderRadius.circular(30)),
                      //     child: const Center(
                      //       child: Text('samuel el jack'),
                      //     )),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //     height: 75,
                      //     width: MediaQuery
                      //         .of(context)
                      //         .size
                      //         .width * 0.8,
                      //     decoration: BoxDecoration(
                      //         color: Colors.pinkAccent,
                      //         borderRadius: BorderRadius.circular(30)),
                      //     child: const Center(
                      //       child: Text('antony hapkings'),
                      //     ))
                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text('Users :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   child: Text(
                  //     'WINNERS ',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold, fontSize: 15),
                  //   ),
                  //
                  // ),
                  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: context.read<ApiService>().getAllwinner(id),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot<
                              Map<String, dynamic>>> snapshot) {
                        if (snapshot.hasData) {
                          List list = snapshot.data!.get('users');
                          return Container(
                            height: 200,
                            child: ListView.builder(
                                itemCount: list.length,

                                itemBuilder: (context,index){
                                  return InkWell(
                                    onTap: (){
                                      kNavigator(context, UserDetail(id: list[index]));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 5),
                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                        height: 75,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.8,
                                        decoration: BoxDecoration(
                                            color: kLightBlue,
                                            borderRadius: BorderRadius.circular(30)),
                                        child: getwinnerdetail(list[index])),
                                  );
                                }),
                          );
                        }
                        return Center(
                            child: const CircularProgressIndicator(
                              color: Colors.black,
                              backgroundColor: Colors.white,));
                      }),
                  ListView(
                    shrinkWrap: true,
                    children: const[

                      // Container(
                      //     height: 75,
                      //     width: MediaQuery
                      //         .of(context)
                      //         .size
                      //         .width * 0.8,
                      //     decoration: BoxDecoration(
                      //         color: Colors.pinkAccent,
                      //         borderRadius: BorderRadius.circular(30)),
                      //     child: const Center(
                      //       child: Text('samuel el jack'),
                      //     )),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //     height: 75,
                      //     width: MediaQuery
                      //         .of(context)
                      //         .size
                      //         .width * 0.8,
                      //     decoration: BoxDecoration(
                      //         color: Colors.pinkAccent,
                      //         borderRadius: BorderRadius.circular(30)),
                      //     child: const Center(
                      //       child: Text('antony hapkings'),
                      //     ))
                    ],
                  )
                ],
              ),


            ],
          ),
        ),

        appBar: AppBar(

          centerTitle: true,
          title: const Text('Users'),
          elevation: 0,
          leading: IconButton(icon:  Icon(Icons.arrow_back_ios),onPressed: (){
            kNavigatorBack(context);
          },),
          backgroundColor: Colors.blue,
        ),
      ),);
  });

}
  getwinnerdetail(id) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: context.read<ApiService>().getAllwinnerdetail(id),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.hasData){
            return Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: snapshot.data!.get('image') == ''
                        ? Text(
                      snapshot.data!.get('name').split('').first,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    )
                        : Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image(
                            image: NetworkImage(snapshot.data!.get('image')),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: Text(snapshot.data!.get('name'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  ),
                ]
            );
          }
          return Center(child: const CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,));
        });
  }



  @override
  void accountAvailable() {
    // TODO: implement accountAvailable
  }

  @override
  void error() {
    // TODO: implement error
  }

  @override
  void inputEmpty() {
    // TODO: implement inputEmpty
  }

  @override
  void inputWrong() {
    // TODO: implement inputWrong
  }

  @override
  void inputnotfill() {
    // TODO: implement inputnotfill
  }

  @override
  void login() {
    // TODO: implement login
  }

  @override
  void passwordWeak() {
    // TODO: implement passwordWeak
  }
}
