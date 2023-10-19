import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }




  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    // body:InkWell(
    //   onTap: (){
    //
    //     Utils.snackBar("No Sandy..", context);
    //     // Utils.flushBarErrorMessage("No items..", context);
    //    // Utils.toastMessage('No internet Connection');
    //    // Navigator.pushNamed(context, RoutesName.home);
    //   },
    //     child: Center(child: Text("Click")))
    // );
    final height = MediaQuery.of(context).size.height * 1;

    final authViewMode = Provider.of<AuthViewModel>(context);
    return Scaffold(

      appBar: AppBar(
        title: Center(child: Text("Sign Up")),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              // onFieldSubmitted: (value){
              //   FocusScope.of(context).requestFocus(passwordFocusNode);
              // },
              onFieldSubmitted:(valu){
                Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
              },
              decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  prefixIcon: Icon(Icons.alternate_email)
              ),
            ),
            ValueListenableBuilder(valueListenable: _obsecurePassword, builder: (context,value, child){
              return TextFormField(
                controller: _passwordController,
                obscureText: _obsecurePassword.value,
                focusNode: passwordFocusNode,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: InkWell(
                        onTap: (){
                          _obsecurePassword.value = !_obsecurePassword.value;
                        },
                        child: Icon(
                            _obsecurePassword.value ? Icons.visibility_off :Icons.visibility))
                ),
              );
            }),
            SizedBox(height: height*0.1),

            RoundButton(
                title:"Sign Up",
                loading: authViewMode.signUpLoading,
                onPress: (){
                  if(_emailController.text.isEmpty){
                    Utils.flushBarErrorMessage("Please enter email", context);
                  }else if(_passwordController.text.isEmpty){
                    Utils.flushBarErrorMessage("Please enter password", context);
                  }else if(_passwordController.text.length <6){
                    Utils.flushBarErrorMessage("Please enter 6 digit password", context);
                  }else{

                    Map data = {
                      'email' : _emailController.text.toString(),
                      'password' : _passwordController.text.toString(),
                    };
                    authViewMode.signUpApi(data , context);
                    print("Api hit");

                  }
                }
            ),
            SizedBox(height: height*.02),

            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.login);
              },
                child: Text("Already have account ? Login")),


          ],
        ),
      ),
    );
  }
}

