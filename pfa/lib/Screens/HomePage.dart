import 'package:flutter/material.dart';
import 'package:pfa/API/QA.dart';
import 'package:pfa/Assistant/TextToSpeech.dart';
import 'package:pfa/Screens/AssistantBubble.dart';
import 'package:pfa/Screens/BottomPart.dart';
import 'package:pfa/Screens/UserBubble.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Message.dart';
import 'AppColors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now;
  TextToSpeech textToSpeech = TextToSpeech();
  ScrollController _scrollController = new ScrollController();
  TextEditingController _textEditingController = TextEditingController();
  String user_name = "";
  List<Message> list_message = [];
  bool isMuted = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => this.user_name = prefs.getString("name"));
      list_message.add(Message(
          content: "Hello ${user_name}, How can I help you? ",
          isQuesion: false));
    });
    super.initState();
  }

  send_message(msg) async {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    setState(() {
      list_message.add(Message(content: msg, isQuesion: true));
      list_message.add(Message( content:"",isQuesion: false));

    });

    Future.delayed(const Duration(seconds: 1), () {

      setState(() {
        list_message.removeLast();
        list_message.add(Message( content:"I am having troubles answering your question, please try again! ",isQuesion: false));

      });



    });




    return false;

    QA.send_question(msg).then((value){
      if(value.statusCode!=200){

       setState(() {
         list_message.add(Message( content:"I am having troubles answering your question, please try again! ",isQuesion: false));
       });
      }
      else{

     setState(() {
       list_message.add(Message( content:value.body,isQuesion: false));
     });
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    now = DateTime.now();
    String user_name = "";
    var day = now.day.toString();
    var month = now.month.toString();
    var year = now.year.toString();
    var hour = now.hour.toString();
    var screen_height = MediaQuery.of(context).size.height;
    var screen_width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            body: Column(
      children: <Widget>[
        Expanded(
            flex: 15,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.lightBlue, Color(0xFF2789be)],
                stops: [0, 1],
              )),
              constraints: BoxConstraints.expand(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          "assets/images/message_logo.png",
                          height: screen_height * 0.15 * 0.6,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: screen_height * 0.15 * 0.3),
                        child: Text(
                          "DR. WILLOW",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screen_width * 0.05,
                    ),
                    child: IconButton(
                      icon: Icon(
                        isMuted ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                        size: screen_width * 0.075,
                      ),
                      onPressed: () {
                        setState(() {
                          this.isMuted = !this.isMuted;
                        });
                      },
                    ),
                  )
                ],
              ),
            )),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              day +
                  '/' +
                  month +
                  '/' +
                  year +
                  ' ' +
                  TimeOfDay(hour: int.parse(hour), minute: 0)
                      .hourOfPeriod
                      .toString() +
                  ':00' +
                  (int.parse(hour) >= 12 ? " PM" : ' AM'),
              style: TextStyle(color: Colors.blueGrey, fontSize: 16),
            ),
          ),
        ),
        Expanded(
          flex: 70,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: list_message.length,
              itemBuilder: (context, index) {
                return !(list_message[index].isQuesion)
                    ? AssistantBubble(
                        width: screen_width,
                        message: list_message[index].content,
                        isMuted:isMuted,
                      )
                    : UserBubble(
                        width: screen_width,
                        message: list_message[index].content,
                      );
              },
            ),
          ),
        ),
        Expanded(
          flex: 15,
          child: BottomPart(
            screen_width: screen_width,
            send_message: this.send_message,
          ),
        )
      ],
    )));
  }
}
