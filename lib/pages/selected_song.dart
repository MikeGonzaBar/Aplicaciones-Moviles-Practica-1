import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectedSong extends StatelessWidget {
  final Map<String, String> songData;
  final bool isFavorite;
  const SelectedSong(
      {super.key, required this.songData, required this.isFavorite});

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
            Image.network("${songData["artwork"]}"),
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
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.spotify),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.deezer),
                ),
                IconButton(
                  onPressed: () {},
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
        actions: <Widget>[
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
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
