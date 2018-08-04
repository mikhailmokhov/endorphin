import 'package:endorphin/common.dart';

class VoiceStatistic {
  VoiceStatModes mode;
  bool enabled;

  VoiceStatistic({mode}){
    this.mode = mode ?? VoiceStatModes.each_km_or_mile;
    this.enabled = false;
  }


}