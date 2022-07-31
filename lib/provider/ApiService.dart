import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kurdivia_admin/constants.dart';
import 'package:kurdivia_admin/screen/add_question.dart';
import 'package:kurdivia_admin/screen/m_question.dart';
import 'package:kurdivia_admin/screen/question_details.dart';
import 'package:ntp/ntp.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

enum LoginStatus { error, login, isLogin, waiting, passwordWrong, emailWrong }
enum UploadData { error, upload, waiting }
enum UploadRecord { vaccine, visit, medicalExam }




class ApiService extends ChangeNotifier {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  //--------------------------------------------------------//
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newTitleController = TextEditingController();


  //--------------------------------------------------------//
  TextEditingController get getEmailController => emailController;

  TextEditingController get getPasswordController => passwordController;
  TextEditingController get getNewTitleController => newTitleController;
//////////////////////sponsor////////////////////////////////////
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController numwinnercontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController oppricecontroller = TextEditingController();

  TextEditingController get getTitleController => titleController;
  TextEditingController get getDescriptionController => descriptionController;
  TextEditingController get getLinkController => linkController;
  ///////////////////////add+question//////////////////////////
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController aController = TextEditingController();
  TextEditingController bController = TextEditingController();
  TextEditingController cController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController get getQuestionController => questionController;
  TextEditingController get getAnswerController => answerController;
  TextEditingController get getAController => aController;
  TextEditingController get getBController => bController;
  TextEditingController get getCController => cController;
  TextEditingController get getTimeController => timeController;



  // [Data] --------------------------------------------//
  String linkType = 'Image';
  String imagePath = '';
  setdate(var val) => date = val ;
  late Timestamp date ;
  setLinkType(String val) => linkType = val;
  setImagePath(String val) {
    imagePath = val;
    notifyListeners();
  }
  String name = 'M';
  String image = '';
  String Phonnumber = '';
  DateTime? dateTime;
  int age = 0;
  int maxsecond = 60;
  String idevents = '';
  int entertime = 0;
  bool iscoming = true;
  int index = 1;
  bool isloading = false;
  String answer = '';
  List list = [];
  bool Filemedia = true;
  String mediaval = 'Image';

  // GET
  bool loadingAuth = false;
  bool isWaitingForCode = false;
  String myVerificationId = '-1';


  bool get isAuthLoading => loadingAuth;

  String get myUser => auth.currentUser!.uid;

  String? get myUserName => auth.currentUser!.email;
  late ApiStatusLogin apiStatus;
  late UploadStatus uploadStatus;
  late ApiStatussave apiStatussave;

  ///////////////////phone_number///////////////////////////
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController get getPhoneNumberController => phoneNumberController;

/////////////////////verification_code//////////////////
  TextEditingController codeController = TextEditingController();

  TextEditingController get getCodeController => codeController;

  ////////////////sign_up_form///////////////////////
  TextEditingController fullNameController = TextEditingController();

  TextEditingController get getFullNameController => fullNameController;
  TextEditingController occupationController = TextEditingController();

  TextEditingController get getOccupationController => occupationController;
  TextEditingController locationController = TextEditingController();

  TextEditingController get getLocationController => locationController;
  TextEditingController ageController = TextEditingController();

  TextEditingController get getAgeController => ageController;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  setmedia(String val){
    mediaval = val;
    notifyListeners();
  }

  bool checkfieldevent(){
    if(titleController.text.isEmpty){
      apiStatussave.inputempty();
      return false;

    }
    else if(imagePath == '-1'){
      apiStatussave.inputempty();
      return false;
    }
    else if(descriptionController.text.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    else if(linkController.text.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    else if(numwinnercontroller.text.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    else if(oppricecontroller.text.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    else if(pricecontroller.text.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    else{
      return true;
    }
  }


  makeNewQuiz(context) async {
    if(titleController.text.isNotEmpty||imagePath.isNotEmpty||descriptionController.text.isNotEmpty||linkController.text.isNotEmpty||numwinnercontroller.text.isNotEmpty||oppricecontroller.text.isNotEmpty||pricecontroller.text.isNotEmpty){
      if(checkfieldevent()){
        if(imagePath!=''){
          isloading = true;
          String filename = '_sponsor_${DateTime.now()} .${imagePath.substring(imagePath.length-3)}';
          File file = File(imagePath);
          TaskSnapshot snapshot = await storage.ref().child('$myUser/sponsor/$filename').putFile(file);
          snapshot.ref.getDownloadURL().then((value){

            Map<String,dynamic> map = {};
            map['file'] = Filemedia;
            map['image']=value;
            map['title'] = titleController.text;
            map['description'] = descriptionController.text;
            map['link']=linkController.text;
            map['date'] = date.toDate().toUtc();
            map['numwinner'] = numwinnercontroller.text;
            map['opprice'] = oppricecontroller.text;
            map['price'] = pricecontroller.text;

            Map<String,dynamic> map1 = {};
            List list = [];
            map1 = {
              'title' : titleController.text,
              'date' : date,
              'users' : list,
              'winner' : list,
            };
            fs.collection('events').doc(titleController.text+date.toString()).collection('data').doc().set(map).then((value) {
              fs.collection('events').doc(titleController.text+date.toString()).set(map1).whenComplete(() {
                isloading = false;
                // kNavigator(context, ManageQuestion());
                kNavigatorBack(context);
              });
            });
          }).onError((error, stackTrace){
            apiStatussave.error();
            print(error);

          });

        }

      }

    }
    else{
      apiStatussave.inputempty();
    }

    // String title = '';
    // if(titleController.text.isNotEmpty){
    //   title = titleController.text;
    // }
    // else{
    //   title='-1';
    // }
    // else{
    //   Map<String,dynamic> map = {};
    //   map['title'] = titleController.text;
    //   map['description'] = descriptionController.text;
    //   map['date'] = date;
    //   map['numusers'] = '';
    //   map['numwinner'] = '';
    //   map['opprice'] = '';
    //   map['price'] = '';
    //   fs.collection('events').doc().collection('data').doc().set(map).onError((error, stackTrace) {
    //     print(error);
    //   });
    // }
  }
  bool checkfieldquestion(){
    if(questionController.text.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    if(answer.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    if(aController.text.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    if(bController.text.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    if(cController.text.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    if(timeController.text.isEmpty){
      apiStatussave.inputempty();
      return false;
    }
    else{
      return true;
    }

    return false;
  }
  AddQuestion(context,id) async {
    if(questionController.text.isNotEmpty || answer.isNotEmpty || aController.text.isNotEmpty ||bController.text.isNotEmpty||cController.text.isNotEmpty||timeController.text.isNotEmpty){
      if(checkfieldquestion()){
        print(imagePath);
        if(imagePath != '' ){
          isloading = true;
          String filename = '_question_${DateTime.now()} .${imagePath.substring(imagePath.length-3)}';
          File file = File(imagePath);
          TaskSnapshot snapshot = await storage.ref().child('$myUser/sponsor/$filename').putFile(file);
          snapshot.ref.getDownloadURL().then((value) {
            List list = [];
            Map<String,dynamic> map = {};
            map['image']=value;
            map['question'] = questionController.text;
            map['answer'] = answer;
            map['a']=aController.text;
            map['b'] = bController.text;
            map['c'] =cController.text;
            map['time'] = int.parse(timeController.text);
            map['answera'] = list;
            map['answerb'] = list;
            map['answerc'] = list;
            fs.collection('events').doc(id).collection('question').doc().set(map).whenComplete(() {
              isloading = false;
              imagePath = '';
              questionController.text='';
              answerController.text='';
              timeController.text='';
              aController.text='';
              bController.text='';
              cController.text='';
              kNavigatorBack(context);
            });
          });
        }
        if(imagePath == '' ){
          isloading = true;
            List list = [];
            Map<String,dynamic> map = {};
          map['image']='';
            map['question'] = questionController.text;
            map['answer'] = answer;
            map['a']=aController.text;
            map['b'] = bController.text;
            map['c'] =cController.text;
            map['time'] = int.parse(timeController.text);
            map['answera'] = list;
            map['answerb'] = list;
            map['answerc'] = list;
            fs.collection('events').doc(id).collection('question').doc().set(map).whenComplete(() {
              imagePath = '';
              questionController.text='';
              answerController.text='';
              timeController.text='';
              aController.text='';
              bController.text='';
              cController.text='';
              kNavigatorBack(context);

            });
        }
      }
    }





    // else{
    //   Map<String,dynamic> map = {};
    //   map['title'] = titleController.text;
    //   map['description'] = descriptionController.text;
    //   map['date'] = date;
    //   map['numusers'] = '';
    //   map['numwinner'] = '';
    //   map['opprice'] = '';
    //   map['price'] = '';
    //   fs.collection('events').doc().collection('data').doc().set(map).onError((error, stackTrace) {
    //     print(error);
    //   });
    // }
  }
  clearInputRegisterVet() {
    // vetDirectionController.text = '';

    notifyListeners();
  }

  getsponsor(Timestamp timestamp)async{
    DateTime ntptime = await NTP.now();
    Timestamp ts = timestamp;
    int second = await ts.toDate().difference(ntptime.toUtc()).inSeconds ;
    print(ts.toDate().toUtc());
    print(ntptime.toUtc());
    print(second);
    if(second > 0 && second <= 300){
      iscoming = true;
      list.add(iscoming);
    }
    else if(second > 300){
      iscoming = true;
      list.add(iscoming);

    }
    else{
      iscoming = false;
      list.add(iscoming);

    }
  }

  apiListener(ApiStatusLogin apiStatus) {
    this.apiStatus = apiStatus;
  }
  apiListenersave(ApiStatussave apiStatussave){
    this.apiStatussave = apiStatussave;
  }


  apiListenerUpload(UploadStatus uploadStatus) {
    this.uploadStatus = uploadStatus;
  }

  setLoading(bool b) {
    loadingAuth = b;
    notifyListeners();
  }
  signIn() async {
    setLoading(true);
    String email = emailController.text;
    String password1 = passwordController.text;
    print(email);
    print(password1);
    await auth
        .signInWithEmailAndPassword(email: email, password: password1)
        .then((value) {
      if (auth.currentUser != null) {
        // if(vet){
        //   fs.collection('vet').doc().get()
        // }else{
        //
        // }
        apiStatus.login();
        print('login');
        setLoading(false);
      } else {
        apiStatus.error();
        setLoading(false);
      }
    }).onError((error, stackTrace) {
      if (error.toString().contains('wrong-password')) {
        apiStatus.inputWrong();
      } else {
        apiStatus.error();
      }
      setLoading(false);
    });
  }


  bool checkLogin() {
    if (auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
  ////////////////////get_data///////////////////
  Future<DocumentSnapshot<Map<String, dynamic>>> getAllUserData() {
    return fs.collection('users').doc(myUser).get();

  }
  // Future<DocumentSnapshot<Map<String, dynamic>>> getAllEventsData() {
  //   return fs.collection('events').doc().get();
  //
  // }





  Stream<QuerySnapshot> getAllUser() {
    return fs.collection('users').snapshots();
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> userData(id){
    return fs.collection('users').doc(id).get();
  }
  Stream<QuerySnapshot> getSponsorDetails(id) {
    return fs.collection('events').doc(id).collection('data').snapshots();
  }
  Stream<QuerySnapshot> getQuestionDetails(id) {
    return fs.collection('events').doc(id).collection('question').snapshots();
  }
  Future<void> deleteQuestionDetails(id,docId) {
    return fs.collection('events').doc(id).collection('question').doc(docId).delete();
  }
  Stream<QuerySnapshot> getAllEvents() {
    return fs.collection('events').orderBy('date').snapshots();
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> getAllwinner(id){
    return fs.collection('events').doc(id).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAllwinnerdetail(x){
    return fs.collection('users').doc(x).get();
  }
  Future<void> deleteEvents(id) {
    return fs.collection('events').doc(id).delete();
  }
  Future<void> updateEvents(id) {
    Map<String,dynamic> map = {};
    map['title'] = newTitleController.text;
    return fs.collection('events').doc(id).update(map);
  }
  getpageindex(int idx){
    index = idx + 1;

    notifyListeners();
  }





  updateProfileImage(String path ) async {
    String filename = '${auth.currentUser?.uid}.${path.substring(path.length-3)}';
    File file = File(path);
    TaskSnapshot snapshot = await storage.ref().child('$myUser/profilPic/$myUser/$filename').putFile(file);
    snapshot.ref.getDownloadURL().then((value){
      Map<String,dynamic> map = {};
      map['image'] = value;
      fs.collection('users').doc(myUser).update(map).whenComplete((){
        uploadStatus.uploaded();
        print('done');
      }).onError((error, stackTrace){
        uploadStatus.error();
      });
    });
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  Future signOut(BuildContext context) async {
    await auth.signOut();
    fs.clearPersistence();

    // kNavigator(context,  MyHomePage());
  }
}

abstract class UploadStatus {
  void error();

  void uploading();

  void uploaded();
}
abstract class ApiStatussave{
  void inputempty();
  void inputwrong();
  void error();
}

abstract class ApiStatusLogin {
  void error();

  void login();

  void inputWrong();

  void inputEmpty();

  void inputnotfill();

  void accountAvailable();

  void passwordWeak();
}

enum SnackBarMode {
  error,warning,success
}

class ModeSnackBar {

  static show(BuildContext context,String text , SnackBarMode snackBarMode){

    Color textColor = Colors.black;
    Color backGroundColor = Colors.green;

    switch(snackBarMode){
      case SnackBarMode.error:
        backGroundColor = Colors.redAccent;
        textColor = Colors.grey;
        break;
      case SnackBarMode.warning:
        backGroundColor = Colors.yellowAccent.shade700;
        textColor = Colors.black;
        break;
      case SnackBarMode.success:
        backGroundColor = Colors.green;
        textColor = Colors.grey;
        break;
    }

    SnackBar snackBar = SnackBar(
      content: Text(text ,style: TextStyle(fontFamily: 'Mont'),),
      backgroundColor: backGroundColor,
      duration: const Duration(seconds: 2),
      elevation: 2,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}


