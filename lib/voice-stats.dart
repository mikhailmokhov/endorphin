import 'package:flutter_tts/flutter_tts.dart';

class VoiceStats {

  FlutterTts flutterTts;
  String language;

  VoiceStats(){
    _initTts();
  }

  _initTts() async {
    flutterTts = new FlutterTts();
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(0.5);
  }

  speak(String text) async {
    flutterTts.speak(text);
  }
}

VoiceStats voiceStats = new VoiceStats();


