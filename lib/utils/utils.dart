
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{


  static void fieldFocusChange(BuildContext context ,FocusNode current , FocusNode next){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }



 static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
            backgroundColor: Colors.black,
      textColor: Colors.white,

    );

  }

  static void flushBarErrorMessage(String message, BuildContext context){

   showFlushbar(context: context,
       flushbar: Flushbar(

         forwardAnimationCurve: Curves.decelerate,
         margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
         padding: EdgeInsets.all(15),
         titleColor: Colors.white,
         borderRadius: BorderRadius.circular(10),
         reverseAnimationCurve: Curves.easeOut,
         flushbarPosition: FlushbarPosition.TOP,
         //flushbarPosition: FlushbarPosition.BOTTOM,


         message: message,
         backgroundColor: Colors.red,
         duration: Duration(seconds: 2),

       )..show(context),
   );
  }

  static snackBar(String message, BuildContext context){
   return ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
       backgroundColor: Colors.red,
         content: Text(message))
   );
  }
}