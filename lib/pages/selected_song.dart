import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica1/providers/favorite_song_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectedSong extends StatelessWidget {
  final dynamic songData;
  bool isFavorite;
  SelectedSong({super.key, required this.songData, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Here you go'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Eliminar de favoritos',
            onPressed: () {
              if (isFavorite) {
                addAlert(context);
              } else {
                print('ADD $songData to favorites');
                context.read<FavoriteProvider>().addNewSong(songData);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
                "${songData["spotify"]["album"]["images"][0]["url"]}"),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                "${songData["title"]}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "${songData["album"]}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Text(
              "${songData["artist"]}",
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            Text(
              "${songData["release_date"]}",
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 20,
                indent: 20,
                endIndent: 0,
                color: Colors.black,
              ),
            ),
            const Text(
              "Abrir con:",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    _launchURL(
                        "${songData["spotify"]["external_urls"]["spotify"]}");
                  },
                  icon: const FaIcon(FontAwesomeIcons.spotify),
                ),
                IconButton(
                  onPressed: () {
                    _launchURL("${songData["song_link"]}");
                  },
                  icon: const FaIcon(FontAwesomeIcons.deezer),
                ),
                IconButton(
                  onPressed: () {
                    _launchURL("${songData["apple_music"]["url"]}");
                  },
                  icon: const FaIcon(FontAwesomeIcons.apple),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String?> addAlert(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Eliminar de favoritos'),
        content: const Text(
            'El elemento será eliminado de tus favoritos ¿Quieres continuar?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancelar');
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Eliminar');
              print('DELETE $songData to favorites');
              context.read<FavoriteProvider>().deleteSong(songData);
              isFavorite = true;
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    print(url);
    print(uri);
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri);
    // } else {
    //   print('Could not launch $uri');
    // }
    if (!await launch(url)) throw 'No se pudo acceder a: $url';
  }
}
