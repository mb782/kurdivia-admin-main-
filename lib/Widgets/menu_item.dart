import 'package:flutter/material.dart';

menuItem(context,text,onPressed){
  return RawMaterialButton(
    onPressed: onPressed,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.9),
                blurRadius: 10,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(

              image: AssetImage('assets/images/3.jpg'),
              fit: BoxFit.cover)),
      child: Center(
        child: Text(text),
      ),
    ),
  );
}