import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

QuestionForm(context,title,controller){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
      Container(
        margin: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.012,horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 15,
                offset: Offset(0, 5),
              )
            ],
            borderRadius: BorderRadius.circular(15)),
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          controller:controller ,
          decoration: InputDecoration(
            filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
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
  );
}