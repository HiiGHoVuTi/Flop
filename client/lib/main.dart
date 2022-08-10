import 'package:flutter/material.dart';

void main() => runApp(const FlopApp());

class FlopApp extends StatelessWidget {
  const FlopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _screensOptions = <Widget>[
    Column(
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
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const [
          Text(
              "ici je mettrai le champ de recherche une fois que j'aurai compris la doc")
        ],
      ),
    ),
    ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {},
          leading: const FlutterLogo(size: 50),
          title: const Text('Titres likés'),
          subtitle: const Text('Playlist'),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        indent: 8,
        endIndent: 8,
      ),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flop!',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: _screensOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Rechercher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_rounded),
            label: 'Bibliothèque',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      bottomSheet: Card(
        margin: const EdgeInsets.all(15),
        child: ListTile(
          onTap: () {},
          leading: const FlutterLogo(size: 35),
          title: const Text(
            'Me and your Mama',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Childish Gambino'),
          trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_arrow_rounded,
              )),
        ),
      ),
    );
  }
}
