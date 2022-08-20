import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'player_state.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({Key? key}) : super(key: key);

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  late FlopPlayerState playerState;

  @override
  void initState() {
    super.initState();
    playerState = FlopPlayerState();
    playerState.player.onPositionChanged.listen((e) => setState(() {}));
    playerState.player.onDurationChanged.listen((e) => setState(() {}));
    playerState.player.onPlayerStateChanged.listen((e) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: height * 0.24,
            child: Container(color: Colors.blue),
          ),
          // Top Bar
          Positioned(
            top: height * 0.016,
            left: 0,
            right: 0,
            child: AppBar(
              foregroundColor: Colors.white,
              title: Text('Lecture en cours'),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.expand_more_rounded),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {},
                )
              ],
            ),
          ),
          // Main Container
          Positioned(
            left: 0,
            right: 0,
            top: height * 0.16,
            height: height * 0.80,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: height * 0.05),
                  FlutterLogo(
                      style: FlutterLogoStyle.markOnly,
                      size: min(height / 3, width * 0.9)),
                  SizedBox(height: height * 0.05),
                  const Text("Machine Gun",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Avenir")),
                  const Text("Jinja, Kira", style: TextStyle(fontSize: 18)),
                  SizedBox(height: height * 0.05),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: Text(
                                "${playerState.position.inMinutes.remainder(60)}:${playerState.position.inSeconds.remainder(60).toString().padLeft(2, '0')}")),
                        Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: Text(
                                "${playerState.duration.inMinutes.remainder(60)}:${playerState.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}")),
                      ]),
                  Slider(
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    value: playerState.position.inSeconds.toDouble(),
                    min: 0,
                    max: playerState.duration.inSeconds.toDouble(),
                    onChanged: (value) => playerState.seekTo(value),
                  ),
                  // NOTE(Maxime): Fast forward and backward aren't programmed yet
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(
                      iconSize: 42,
                      color: playerState.shuffling ? Colors.blue : Colors.grey,
                      icon: const Icon(Icons.shuffle_rounded),
                      onPressed: () => setState(
                          () => playerState.shuffling = !playerState.shuffling),
                    ),
                    IconButton(
                      iconSize: 42,
                      color: Colors.blue,
                      icon: const Icon(Icons.fast_rewind),
                      onPressed: () {},
                    ),
                    IconButton(
                        iconSize: 72,
                        color: Colors.blue,
                        icon: Icon(
                            playerState.player.state == PlayerState.playing
                                ? Icons.pause_circle
                                : Icons.play_circle),
                        onPressed: () => setState(playerState.switchPlay)),
                    IconButton(
                      iconSize: 42,
                      color: Colors.blue,
                      icon: const Icon(Icons.fast_forward),
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 42,
                      color: playerState.looping ? Colors.blue : Colors.grey,
                      icon: const Icon(Icons.repeat_rounded),
                      onPressed: () => setState(
                          () => playerState.looping = !playerState.looping),
                    ),
                  ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
