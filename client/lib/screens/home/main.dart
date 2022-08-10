import 'package:flutter/material.dart';

Widget home = Column(
  children: [
    const Padding(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Text(
        'Bonjour Maxime, comment se passe votre journée ?',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        textAlign: TextAlign.center,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
                onTap: () {},
                leading: const Icon(Icons.device_hub),
                title: const Text('Statut du serveur'),
                subtitle: Row(
                  children: const [
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'En Ligne',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_rounded)),
            // NOTE(Maxime):
            // devices list might be useless for now, as it will be implemented later
            // FIXME(Valentin): overflows down
            /*
                ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.monitor),
                    title: const Text('PC Maxime'),
                    subtitle: Row(
                      children: const [
                        Icon(
                          Icons.music_note_rounded,
                          color: Colors.blue,
                          size: 15,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Mécanique des fluides - Luidji',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow),
                        label: const Text(''))),
                */
          ],
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.lightBlue,
        child: ListTile(
          onTap: () {},
          iconColor: Colors.white,
          textColor: Colors.white,
          title: const Text('Titres likés'),
          subtitle: const Text('Voir la playlist'),
          leading: const Icon(Icons.star),
          trailing: const Icon(Icons.arrow_forward_rounded),
        ),
      ),
    ),
    const SizedBox(
      height: 10,
    ),
    ListTile(
      title: const Text('Autres playlists'),
      trailing: const Icon(Icons.arrow_forward_rounded),
      onTap: () {},
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(5, (index) {
          return const Card(
            child: Text('Playlist cover'),
          );
        }),
      ),
    ),
  ],
);
