import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kurdivia_admin/Model/user.dart';
import 'package:kurdivia_admin/screen/user_details.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';

import '../Widgets/link_type.dart';
import '../Widgets/question_form.dart';
import '../Widgets/video_player_widget.dart';
import '../constants.dart';
import '../provider/ApiService.dart';
import 'menu.dart';
import 'dart:io';

class ManageSponsor extends StatefulWidget {
  ManageSponsor({Key? key}) : super(key: key);

  bool visible = false;
  var selectedDate = DateTime.now();

  @override
  State<ManageSponsor> createState() => _ManageSponsorState();
}

class _ManageSponsorState extends State<ManageSponsor>
    implements ApiStatussave {
  late BuildContext context;
  late VideoPlayerController controller;

  final picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose() {
    controller.pause();
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02,
                ),
                const Text('fill sponsor details', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white),),
                SizedBox(
                  height: 10,
                ),
                const Text('Select Time :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                Center(
                  child: InkWell(
                    onTap: () {
                      pickDateTime(context);
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: MediaQuery
                            .of(context)
                            .size
                            .height * 0.01, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.8),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              )
                            ],
                            borderRadius: BorderRadius.circular(15)),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.05,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.7,
                        child: Center(child: Text(
                          widget.selectedDate.toString(), style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),))
                    ),
                  ),
                ),

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 176),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.75,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 20,
                    offset: Offset(0, -8),
                  )
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionForm(context, 'Title', value.titleController),
                  QuestionForm(context, 'description', value.descriptionController),
                  QuestionForm(context, 'Link', value.linkController),
                  QuestionForm(context, 'Number of winner', value.numwinnercontroller),
                  QuestionForm(context, 'price', value.pricecontroller),
                  QuestionForm(context, 'Type of prize split', value.oppricecontroller),
                  const Text('Link Type',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  LinkType(
                    myHint: 'Image',
                    onChanged: (val) {
                      value.setLinkType(val.toString());
                      value.notifyListeners();
                    },
                  ),
                  const Text(
                      'Media', style: TextStyle(fontWeight: FontWeight.bold)),
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
                      child: (value.imagePath.isNotEmpty )
                          ? (value.mediaval == 'Video')
                          ?Stack(children: [ClipRRect(borderRadius: BorderRadius.circular(15),child: VideoPlayerWidget(controller: controller))],)
                        :Stack(
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
                      )
                          :IconButton(
                        onPressed: () async {
                          {
                            if (value.mediaval == 'Video' ) {
                              value.Filemedia = false;
                              // final pickedFile =
                              // await ImagePicker().pickVideo(
                              //     source: ImageSource.gallery);
                              // if (pickedFile != null) {
                              //   context.read<ApiService>().setImagePath(
                              //       pickedFile.path);
                              // }
                              // PickedFile? pickedFile = await picker.getVideo(source: ImageSource.gallery);
                              // _video = File(pickedFile!.path);
                              // _videoPlayerController = VideoPlayerController.file(_video!)
                              //   ..addListener(() => setState(() {}))
                              //   ..setLooping(true)
                              //   ..initialize().then((_) {
                              //   setState(() { });
                              //   _videoPlayerController!.play();
                              // });
                              final file = await pickVideoFile();
                              if (file == null) return;

                              value.imagePath = file.path;
                              controller = VideoPlayerController.file(file)
                                ..addListener(() => setState(() {}))
                                ..setLooping(true)
                                ..initialize().then((_) {
                                  controller.play();
                                  setState(() {});
                                });
                            }
                            else if (value.mediaval == 'Image') {
                              value.Filemedia = true;
                              final pickedFile =
                              await ImagePicker().pickImage(
                                  source: ImageSource.gallery);
                              print(pickedFile);
                              if (pickedFile != null) {
                                context.read<ApiService>().setImagePath(
                                    pickedFile.path);
                              }
                            }
                          }
                        },
                        icon: (value.mediaval == 'Video') ? const Icon(
                            Icons.video_call_rounded) : const Icon(
                            Icons.add_a_photo_outlined), iconSize: 50,
                      ),

                    ),
                    ),

                  //QuestionForm(context, 'media',''),
                  // Column(
                  //   children: [
                  //     RadioListTile(
                  //       groupValue: radioItem,
                  //       title: Text('video'),
                  //       value: 'Item 1',
                  //       onChanged: (val) {
                  //         setState(() {
                  //           radioItem = val;
                  //         });
                  //       },
                  //     ),
                  //     RadioListTile(
                  //       groupValue: radioItem,
                  //       title: Text('image'),
                  //       value: 'Item 1',
                  //       onChanged: (val) {
                  //         setState(() {
                  //           radioItem = val;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),


                  RawMaterialButton(
                    onPressed: () {
                      value.setdate(Timestamp.fromDate(widget.selectedDate));
                      //print();
                      value.notifyListeners();
                      value.makeNewQuiz(context);
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            color: kButtonBlue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 15,
                                offset: Offset(0, 3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.05,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                        child: const Center(
                            child: Text(
                              'save',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
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
        ),)
        );
      },
    );
  }



  @override
  void inputempty() {
    ModeSnackBar.show(
        context, 'Fill in all the fields', SnackBarMode.warning);
  }

  @override
  void inputwrong() {
    // TODO: implement inputwrong
  }

  @override
  void error() {
    ModeSnackBar.show(context, 'something go wrong', SnackBarMode.error);
  }

  Future<File?> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) return null;

    return File(result.files.single.path!);
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
      lastDate: DateTime(DateTime
          .now()
          .year + 5), initialDate: DateTime.now(),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context, initialTime: initialTime
      // context: context,
      // initialTime: widget.selectedDate != null
      //     ? TimeOfDay(hour: widget.selectedDate!.hour, minute: widget.selectedDate!.minute)
      //     : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }


}
