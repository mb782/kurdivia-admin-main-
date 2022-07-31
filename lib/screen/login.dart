import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../provider/ApiService.dart';
import 'menu.dart';

class Login extends StatelessWidget implements ApiStatusLogin {
  Login({Key? key}) : super(key: key);
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
                      child: Scaffold(
                        body: Stack(
                          children: [
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/1.jpg"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                height: 350,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30))
                                ),
                                child:Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          color: kLightGreen,
                                          borderRadius: BorderRadius.circular(20)),
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      child: TextField(
                                        controller:value.emailController ,
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
                                            hintText: "user name",
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            )),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          color: kLightGreen,
                                          borderRadius: BorderRadius.circular(20)),
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      child: TextField(
                                        controller:value.passwordController ,
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
                                            hintText: "password",
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            )),
                                      ),
                                    ),
                                    RawMaterialButton(
                                      onPressed: () {
                                        value.signIn();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 20),
                                        decoration: BoxDecoration(
                                            color: kButtonBlue,
                                            borderRadius: BorderRadius.circular(20)),
                                        height: MediaQuery.of(context).size.height * 0.07,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Center(child: Text('Login',style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
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
    kNavigator(context, Menu());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }

  @override
  void inputnotfill() {
    // TODO: implement inputnotfill
  }
}
