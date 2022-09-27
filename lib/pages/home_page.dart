import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:practica1/pages/favorites.dart';
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
                  setState(() {});
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
                    builder: (context) => Favorites(),
                  ),
                );
              },
              backgroundColor: Colors.grey[100],
              tooltip: "Ver en favoritos",
              child: const Icon(
                Icons.favorite,
                color: Colors.black,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
