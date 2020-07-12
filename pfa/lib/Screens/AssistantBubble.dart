import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:pfa/Assistant/TextToSpeech.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'AppColors.dart';
class AssistantBubble extends StatefulWidget  {
  var width;
  String message;
  bool isMuted;

  AssistantBubble({this.width, this.message,this.isMuted});

  @override
  _AssistantBubbleState createState() => _AssistantBubbleState(width: width,message: message,isMuted:this.isMuted);
}

class _AssistantBubbleState extends State<AssistantBubble> {
  var width=0.0;
  String message;
  bool isMuted;
  TextToSpeech textToSpeech;

  _AssistantBubbleState({this.width, this.message,this.isMuted});


  @override
  initState(){
    print("hi at the start"+isMuted.toString());
    textToSpeech = TextToSpeech();
if(!isMuted) {
  print("here");
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
            child: (message.isNotEmpty)? Text(
             this.message,
              textAlign: TextAlign.left,
              style: TextStyle(color: AppColors.textColor, fontSize: 16),
            ):Container(
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
