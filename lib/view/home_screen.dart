import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final userPrefernece = Provider.of<UserViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: (){
              userPrefernece.remove().then((value){
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
              child: Center(child: Text("Logout")))
        ],
      ),
    );
  }
}
