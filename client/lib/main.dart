import 'package:flutter/material.dart';
import 'package:flop/screens/home/home.dart';
import 'package:flop/screens/playing/playing.dart';

void main() => runApp(const FlopApp());

class FlopApp extends StatelessWidget {
  const FlopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const MainScreen(),
        "/playing": (context) => const PlayingScreen(),
      },
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

  final _homeOptions = homeScreensOptions;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

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
          style: TextStyle(color: Colors.black, fontSize: 32),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: _homeOptions.elementAt(_selectedIndex),
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
          onTap: () => Navigator.pushNamed(context, "/playing"),
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
