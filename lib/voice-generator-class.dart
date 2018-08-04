import 'package:flutter_tts/flutter_tts.dart';

class VoiceGenerator {
  static const _DEFAULT_SPEED_RATE = 1.0;
  static const _DEFAULT_VOLUME = 1.0;
  static const _DEFAULT_PITCH = 1.0;
  FlutterTts _flutterTts;

  VoiceGenerator(){
    _initTts();
  }

  _initTts() async {
    _flutterTts = new FlutterTts();
    await _flutterTts.setSpeechRate(_DEFAULT_SPEED_RATE);
    await _flutterTts.setVolume(_DEFAULT_VOLUME);
    await _flutterTts.setPitch(_DEFAULT_PITCH);
  }

  speak(String text) async {
    _flutterTts.speak(text);
  }
}


