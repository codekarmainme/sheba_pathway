import 'package:flutter/material.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({super.key,required this.historyname, required this.date});
  final String historyname;
  final String date;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(historyname,style: normalText.copyWith(color: black2,fontWeight: FontWeight.bold),),
            Text(date,style: smallText.copyWith(color: black2.withOpacity(0.5)),),
            Text("Not rated",style: smallText,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(onPressed: (){}, label: Text("Review",style: smallText,),icon: Icon(Icons.star),),
                TextButton.icon(onPressed: (){}, label: Text("Re-route",style: smallText,),icon: Icon(Icons.route)),

              ],
            )
          ],
        ),
      ),
    );
  }
}