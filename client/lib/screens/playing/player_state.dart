import 'package:audioplayers/audioplayers.dart';

class FlopPlayerState {
  AudioPlayer player = AudioPlayer();
  String path = "https://www2.cs.uic.edu/~i101/SoundFiles/CantinaBand60.wav";
  Duration duration = const Duration();
  Duration position = const Duration();
  bool looping = false;
  bool shuffling = false;

  FlopPlayerState() {
    player.onDurationChanged.listen((d) => duration = d);
    player.onPositionChanged.listen((p) => position = p);
    player.setSourceUrl(path);
  }

  play() {
    player.resume();
  }

  pause() {
    player.pause();
  }

  seekTo(double t) async {
    await player.seek(Duration(seconds: t.toInt()));
    await player.resume();
  }

  switchPlay() {
    if (player.state != PlayerState.playing) {
      play();
    } else {
      pause();
    }
  }
}
