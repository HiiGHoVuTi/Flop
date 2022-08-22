import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flop/screens/home/home.dart';
import 'package:flop/screens/playing/playing.dart';

void main() => runApp(const FlopApp());

class FlopApp extends StatelessWidget {
  const FlopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // French, no country code
      ],
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

  Route _toMediaPlayerRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const PlayingScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _homeOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home), label: AppLocalizations.of(context).home),
          NavigationDestination(icon: const Icon(Icons.search), label: AppLocalizations.of(context).search),
          NavigationDestination(
              icon: const Icon(Icons.music_note), label: AppLocalizations.of(context).library),
        ],
      ),
      bottomSheet: ListTile(
        onTap: () => Navigator.of(context).push(_toMediaPlayerRoute()),
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
    );
  }
}
