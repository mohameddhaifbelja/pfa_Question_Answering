import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';

class UserBubble extends StatefulWidget {
  var width;
  String message;

  UserBubble({this.width, this.message});
  @override
  _UserBubbleState createState() => _UserBubbleState(width:width,message: message);
}

class _UserBubbleState extends State<UserBubble> {
  var width=0.0;
  String message;
  _UserBubbleState({this.width, this.message});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[ Expanded(
        flex: 1,
        child: Bubble(
          alignment: Alignment.topRight,
          margin: BubbleEdges.only(
            top: 10,
            right: width*0.05,
            left: width * 0.2,
            bottom: 5,
          ),
          padding: BubbleEdges.symmetric(vertical: 5, horizontal: 10),
          elevation: 0,

          nip: BubbleNip.rightBottom,
          color: AppColors.dartBoxColor,
          child: Text(
            this.message,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),],
    );
  }
}
