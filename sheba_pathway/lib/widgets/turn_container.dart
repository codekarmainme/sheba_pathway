import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

import 'package:provider/provider.dart';

class TurnContainer extends StatefulWidget {
  const TurnContainer({
    super.key,
    required this.instruction,
    required this.length,
    required this.street_name,
    required this.time,
    required this.type,
    required this.lat,
    required this.lon,
  
  });

  final String instruction;
  final String length;
  final String time;
  final String street_name;
  final int type;
  final double lat;
  final double lon;
  

  @override
  State<TurnContainer> createState() => _TurnContainerState();
}

class _TurnContainerState extends State<TurnContainer>
    with SingleTickerProviderStateMixin {
  
  bool isSpeaking = false;
  // final FlutterTts _flutterTts = FlutterTts();

  IconData _getManeuverIcon(int type) {
    switch (type) {
      case 2:
        return Icons.my_location;
      case 5:
        return Icons.flag;
      case 9:
        return Icons.turn_slight_right;
      case 10:
        return Icons.turn_right;
      case 11:
        return Icons.turn_sharp_right;
      case 12:
        return Icons.u_turn_right;
      case 13:
        return Icons.u_turn_left;
      case 14:
        return Icons.turn_sharp_left;
      case 15:
        return Icons.turn_left;
      case 16:
        return Icons.turn_slight_left;
      case 26:
        return Icons.login;
      case 27:
        return Icons.logout;
      default:
        return Icons.directions;
    }
  }

  @override
  void initState() {
    super.initState();
 
    // _initializeTts();
  }

 

  // void _initializeTts() {
  //   _flutterTts.setCompletionHandler(() {
  //     if (mounted) {
  //       setState(() {
  //         isSpeaking = false;
  //       });
  //     }
  //   });

  //   _flutterTts.setErrorHandler((error) {
  //     if (mounted) {
  //       setState(() {
  //         isSpeaking = false;
  //       });
  //     }
  //   });
  // }

  @override
  void dispose() {
   
    // _flutterTts.stop();
    super.dispose();
  }

  // Future<void> _speakInstruction(String instruction) async {
  //   setState(() {
  //     isSpeaking = true;
  //   });

  //   try {
  //     await _flutterTts.setLanguage("en-US");
  //     await _flutterTts.setPitch(1);
  //     await _flutterTts.speak(instruction);
  //   } catch (e) {
  //     setState(() {
  //       isSpeaking = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: const EdgeInsets.all(8.0),
          child:Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        _getManeuverIcon(widget.type,),
                        size: 25,
                       color: purpleColor
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                widget.instruction,
                                style: normalText.copyWith(color: black2.withOpacity(0.5),fontWeight: FontWeight.bold),
                                
                              ),
                            ),
                            Text("${widget.length} km",style: smallText.copyWith(color: black2.withOpacity(0.5),fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
              
          ),
        );
      
  }
}