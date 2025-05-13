import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/view_screen.dart';

class TopTripContainer extends StatelessWidget {
  const TopTripContainer({super.key,required this.assetName,required this.locaition,required this.price,required this.placeName});
 final String assetName;
 final String locaition;
 final String price;
 final String placeName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width *0.5,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
      
              )
            ],
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height:100,
                      width: MediaQuery.of(context).size.width *0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(assetName),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                           borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.arrow_forward,color: Colors.white,size: 15,),
                          )),
                      ),
                    )
                  ],
                ),
                   Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                width: MediaQuery.of(context).size.width *0.25,
                child: Text(placeName,style:normalText.copyWith(color:black2,fontWeight: FontWeight.bold),)),
               Container(
                child: Row(
                  
                  children: [
                    Icon(Icons.star,color: Colors.amber,size:15),
                    Text("4.5",style: normalText.copyWith(color: Colors.black.withOpacity(0.5)),)
                  ],
                ),
               )
             ],
                   ),
                   SizedBox(height: 10,),
                   Row(
            children: [
              Icon(Icons.location_on, color: Colors.black.withOpacity(0.5),size: 15,),
              Text(locaition,style: normalText.copyWith(color: Colors.black.withOpacity(0.5)),)
            ],
                   ),
                   Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
              Text("$price /visit",style: smallText.copyWith(color:black2,),),
              Icon(FontAwesomeIcons.heart,color: primaryColor,size: 15,)
            ],
                   )
              ],
            ),
          ),
        
        ),
      ),
    );
  }
}