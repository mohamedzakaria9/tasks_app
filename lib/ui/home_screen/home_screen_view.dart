import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/services/shared_pref_services.dart';

class HomeScreenView extends StatelessWidget {
  final SharedPrefServices sharedPrefServices;
  const HomeScreenView(this.sharedPrefServices,{super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("this is the name ${sharedPrefServices.name!}"),
            Text("this is the email ${sharedPrefServices.email!}"),
            Text("this is the id ${sharedPrefServices.id}"),
          ],
        ),
      ),
    );
  }
}
