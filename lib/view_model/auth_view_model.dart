import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/respository/auth_respository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';

import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading (bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading (bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data , BuildContext context) async{

    setLoading(true);

    _myRepo.loginApi(data).then((value){

      setLoading(false);
      Utils.flushBarErrorMessage("login Successfully", context);

      Navigator.pushNamed(context, RoutesName.home);
       if(kDebugMode){
       print(value.toString());

       }
    }).onError((error, stackTrace){
      setLoading(false);
         // Utils.flushBarErrorMessage(error.toString(), context);
         if(kDebugMode){
           print(error.toString());
         }
    });
  }


  Future<void> signUpApi(dynamic data , BuildContext context) async{

    setLoading(true);

    _myRepo.signUpApi(data).then((value){

      setSignUpLoading(false);
      Utils.flushBarErrorMessage("Sign Up Successfully", context);

      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());

      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      // Utils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

}