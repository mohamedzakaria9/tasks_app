import 'package:flutter/cupertino.dart';

class StatusBadge extends StatelessWidget {
  final Color statusColor;
  final String status;
  final Color textColor;
  const StatusBadge({required this.status,required this.statusColor,required this.textColor,super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.003),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: statusColor,
      ),

      child: Text(status,style: TextStyle(color: textColor,fontWeight: FontWeight.bold),),);
  }
}
