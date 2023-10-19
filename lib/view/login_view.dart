import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/signup_view.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

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
        title: Center(child: Text("Login")),
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
                title:"Login",
                loading: authViewMode.loading,
                onPress: (){
                   if(_emailController.text.isEmpty){
                     Utils.flushBarErrorMessage("Please enter email", context);
                   }else if(_passwordController.text.isEmpty){
                     Utils.flushBarErrorMessage("Please enter password", context);
                   }else if(_passwordController.text.length <6){
                     Utils.flushBarErrorMessage("Please enter 6 digit password", context);
                   }else{

                     // Map data = {
                     //   'email' : _emailController.text.toString(),
                     //   'password' : _passwordController.text.toString(),
                     // };

                     Map data = {
                       'email' :  "eve.holt@reqres.in",
                       'password' :"cityslicka",
                     };


                     authViewMode.loginApi(data , context);
                     print("Api hit");

                   }
                }
            ),
             SizedBox(height: height*.02),
            
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.signUp );
               // Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpView()));
              },
                child: Text("Don't have account ? Sign Up")),
            

          ],
        ),
      ),
    );
  }
}
