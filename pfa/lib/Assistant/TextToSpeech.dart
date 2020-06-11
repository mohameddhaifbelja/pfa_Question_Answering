import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech{
  FlutterTts flutterTts;
  TextToSpeech(){
     this.flutterTts = FlutterTts();

  }
  speak(message) async{
    var result = await flutterTts.speak(message);
    print(result);

  }
  Future stop() async{
    var result = await flutterTts.stop();
  }
}