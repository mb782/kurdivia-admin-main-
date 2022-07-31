import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kurdivia_admin/Widgets/question_form.dart';
import 'package:kurdivia_admin/constants.dart';

import 'package:flutter/cupertino.dart';

import 'package:kurdivia_admin/screen/question_details.dart';

import 'package:provider/provider.dart';

import '../Widgets/question_form.dart';
import '../constants.dart';
import '../provider/ApiService.dart';


class AddQuestion extends StatefulWidget {
  var id;

  AddQuestion({Key? key, required this.id}) : super(key: key);

  bool visible = false;
  var selectedDate=DateTime.now();
  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion>
    with SingleTickerProviderStateMixin implements ApiStatussave {
  late BuildContext context;

  bool selecteda = false;
  bool selectedb = false;
  bool selectedc = false;






  @override
  Widget build(BuildContext context) {
    context.read<ApiService>();
    this.context = context;
    return Consumer<ApiService>(
      builder: (context, value, child) {
        value.apiListenersave(this);
        return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/2.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Text('Select Time :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                              // Center(
                              //   child: InkWell(
                              //     onTap: (){
                              //       pickDateTime(context);
                              //     },
                              //     child: Container(
                              //         margin: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.012,horizontal: 20),
                              //         decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius: BorderRadius.circular(20)),
                              //         height: MediaQuery.of(context).size.height * 0.05,
                              //         width: MediaQuery.of(context).size.width * 0.7,
                              //         child: Center(child: Text(widget.selectedDate.toString()))
                              //     ),
                              //   ),
                              // ),
                              Text('Question Time :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.012,horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.6),
                                        blurRadius: 15,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15)),
                                height: MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: TextField(
                                  controller:value.timeController ,
                                  keyboardType: TextInputType.number,
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
                                      // hintText: "user name",
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 0,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          height: MediaQuery.of(context).size.height*0.82,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30))),
                          child: Column(
                            children: [
                              QuestionForm(context, 'Question :',value.questionController),
                              QuestionForm(context, 'A :',value.aController),
                              QuestionForm(context, 'B :',value.bController),
                              QuestionForm(context, 'C :',value.cController),
                              Row(
                                children: [
                                  Text('Answer :',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(width: 20,),
                                  Text('A',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Checkbox(value: selecteda, onChanged: (val){
                                    selecteda = val!;
                                    selectedb = false;
                                    selectedc = false;
                                    value.answer = value.aController.text;
                                    value.notifyListeners();
                                  }),
                                  SizedBox(width: 20,),
                                  Text('B',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Checkbox(value: selectedb, onChanged: (val){
                                    selectedb = val!;
                                    selecteda = false;
                                    selectedc = false;
                                    value.answer = value.bController.text;
                                    value.notifyListeners();
                                  }),
                                  SizedBox(width: 20,),
                                  Text('C',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Checkbox(value: selectedc, onChanged: (val){
                                    selectedc = val!;
                                    selecteda = false;
                                    selectedb = false;
                                    value.answer = value.cController.text;
                                    value.notifyListeners();
                                  }),

                                ],
                              ),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text (
                                    'Media :', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.012, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.7),
                                        blurRadius: 16,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15)),
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.15,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.8,
                                child: Center(
                                  child: value.imagePath.isNotEmpty ? Stack(
                                    children: [
                                      Image.file(File(value.imagePath)),
                                      Positioned(
                                          right: -12,
                                          top: -15,
                                          child: IconButton(onPressed: () {
                                            value.imagePath = '';
                                            value.notifyListeners();
                                          },
                                            icon: const Icon(Icons.rotate_left_outlined,
                                              color: Colors.red,),)),

                                    ],
                                  ) : IconButton(
                                    onPressed: () async {
                                      {
                                          final pickedFile =
                                          await ImagePicker().pickImage(
                                              source: ImageSource.gallery);
                                          print(pickedFile);
                                          if (pickedFile != null) {
                                            context.read<ApiService>().setImagePath(
                                                pickedFile.path);
                                          }
                                      }
                                    },
                                    icon: const Icon(
                                        Icons.add_a_photo_outlined), iconSize: 50,
                                  ),
                                ),

                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      value.notifyListeners();
                                      value.AddQuestion(context, widget.id);
                                      // kNavigator(context, QuestionDetails(id:widget.id));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          color: kButtonBlue,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.7),
                                              blurRadius: 16,
                                              offset: Offset(0, 5),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(20)),
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      child: const Center(
                                          child: const Text(
                                            'finish',
                                            style: TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     value.AddQuestion(context, widget.id);
                                  //     value.questionController.text='';
                                  //     value.answerController.text='';
                                  //     value.timeController.text='';
                                  //     value.aController.text='';
                                  //     value.bController.text='';
                                  //     value.cController.text='';
                                  //     kNavigator(context,  AddQuestion(id: widget.id));
                                  //   },
                                  //   child: Container(
                                  //     margin: const EdgeInsets.symmetric(vertical: 20),
                                  //     decoration: BoxDecoration(
                                  //         color: kLightGreen,
                                  //         borderRadius: BorderRadius.only(bottomRight:Radius.circular(20),topRight: Radius.circular(20))),
                                  //     height: MediaQuery.of(context).size.height * 0.05,
                                  //     width: MediaQuery.of(context).size.width * 0.3,
                                  //     child: const Center(
                                  //         child: const Text(
                                  //           'next',
                                  //           style: TextStyle(color: Colors.white),
                                  //         )),
                                  //   ),
                                  // ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  value.isloading ? const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Center(child: CircularProgressIndicator(
                        color: Colors.black, backgroundColor: Colors.white,))): Container(),
                ],
              ),
            ));

      },
    );
  }

  @override
  void inputempty() {
    ModeSnackBar.show(
        context, 'Fill in all the fields', SnackBarMode.warning);
  }



  @override
  void error() {
    ModeSnackBar.show(context, 'something go wrong', SnackBarMode.error);
  }



  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      widget.selectedDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
   // print(widget.selectedDate);
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,

      //initialDate: widget.selectedDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5), initialDate: DateTime.now(),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(context: context, initialTime: initialTime
      // context: context,
      // initialTime: widget.selectedDate != null
      //     ? TimeOfDay(hour: widget.selectedDate!.hour, minute: widget.selectedDate!.minute)
      //     : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }


  @override
  void inputwrong() {
    // TODO: implement inputwrong
  }
}
