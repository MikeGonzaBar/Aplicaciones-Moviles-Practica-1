import 'dart:async';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica1/pages/favorites.dart';
import 'package:practica1/providers/favorite_song_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _animate = false;
  String msg = "Toque para escuchar";
  Record record = Record();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 120, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              msg,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            AvatarGlow(
              glowColor: Colors.purple,
              endRadius: 200.0,
              animate: _animate,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: MaterialButton(
                shape: const CircleBorder(),
                onPressed: () {
                  _animate = !_animate;

                  msg = (msg == "Escuchando...")
                      ? "Toque para escuchar"
                      : "Escuchando...";
                  recordingTrack();
                  setState(() {});
                  Timer(Duration(seconds: 4), () async {
                    msg = (msg == "Escuchando...")
                        ? "Toque para escuchar"
                        : "Escuchando...";
                    _animate = !_animate;
                    setState(() {});
                  });
                },
                child: const CircleAvatar(
                  radius: 72,
                  backgroundImage: AssetImage('assets/images/listening.gif'),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Favorites(),
                  ),
                );
              },
              backgroundColor: Colors.pink[500],
              tooltip: "Ver favoritos",
              child: const Icon(
                Icons.favorite,
                color: Colors.lightBlue,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> recordingTrack() async {
    Directory? appDocDir = await getExternalStorageDirectory();
    String? appPath = appDocDir?.path;

    print(appPath);
    if (await record.hasPermission()) {
      // Start recording
      await record.start(
        path: '$appPath/newTrack.m4a',
        encoder: AudioEncoder.aacLc, // by default
        bitRate: 128000, // by default
        samplingRate: 44100, // by default
      );
    }

// Get the state of the recorder
    bool isRecording = await record.isRecording();
    if (isRecording) {
      Timer(Duration(seconds: 4), () async {
        print("Yeah, this line is printed after 4 seconds");
        String? songPath = await record.stop();
        print(songPath);
        context.read<FavoriteProvider>().searchSong(songPath!);
      });
    }
// Stop recording
  }
}
