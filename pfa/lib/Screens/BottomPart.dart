import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

import 'AppColors.dart';

class BottomPart extends StatefulWidget {
  @override
  double screen_width;
  Function send_message;

  BottomPart({this.screen_width, this.send_message});

  _BottomPartState createState() =>
      _BottomPartState(screen_width: screen_width, send_message: send_message);
}

class _BottomPartState extends State<BottomPart> {
  //Related to speechRecoginition:
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  double screen_width;
  Function send_message;
  TextEditingController _textEditingController = TextEditingController();
  bool isListening = false;

  _BottomPartState({this.screen_width, this.send_message});

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) {
        print('hi there');
        _textEditingController.text = speech;
      },
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    this.initSpeechRecognizer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: screen_width * 0.03),
            width: screen_width * 0.8,
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              style: TextStyle(fontSize: 20),
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                suffix: IconButton(
                  icon: Icon(
                    isListening ? Icons.stop : Icons.mic,
                    color: AppColors.buttonColor,
                    size: screen_width * 0.08,
                  ),
                  onPressed: () {
                    setState(() {
                      isListening = !isListening;
                      if (isListening) {
                        if (_isAvailable && !_isListening)
                          _speechRecognition
                              .listen(locale: "en_US")
                              .then((result) => print('$result'));
                      } else {
                        if (_isListening)
                          _speechRecognition.stop().then(
                                (result) => setState(() => _isListening = result),
                          );
                      }
                    });
                  },
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: AppColors.buttonColor,
              size: screen_width * 0.08,
            ),
            onPressed: () {
              if (_textEditingController.text.isNotEmpty) {
                this.send_message(_textEditingController.text);
                _textEditingController.text = '';
              }
            },
          )
        ],
      ),
    );
  }
}
