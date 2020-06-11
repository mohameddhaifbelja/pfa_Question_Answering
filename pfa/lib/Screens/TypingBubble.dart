import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:pfa/Assistant/TextToSpeech.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'AppColors.dart';
class TypingBubble extends StatefulWidget  {
  var width;
  String message;
  bool isMuted;

  TypingBubble({this.width, this.message,this.isMuted});

  @override
  _TypingBubbleState createState() => _TypingBubbleState(width: width,message: message,isMuted:this.isMuted);
}

class _TypingBubbleState extends State<TypingBubble> {
  var width=0.0;
  String message;
  bool isMuted;
  TextToSpeech textToSpeech;

  _TypingBubbleState({this.width, this.message,this.isMuted});


  @override
  initState(){
    textToSpeech = TextToSpeech();
    if(!isMuted) {
      textToSpeech.speak(this.message);
    }
    super.initState();

  }
  void dispose(){
    textToSpeech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.asset("assets/images/sent_logo.png",height: width*0.1,),
        Expanded(
          flex: 1,
          child: Bubble(
            alignment: Alignment.bottomLeft,
            margin: BubbleEdges.only(
              top: 10,

              right: width*0.15,
              bottom: 25,
            ),
            padding: BubbleEdges.symmetric(vertical: 5, horizontal: 10),
            elevation: 0,
            nip: BubbleNip.leftBottom,
            color: AppColors.lightBoxColor,
            child:Container(
              width: width*0.1,
              child: SpinKitThreeBounce(
                color: AppColors.textColor,
                // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),

                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
