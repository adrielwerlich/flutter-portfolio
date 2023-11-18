import 'package:flutter/material.dart';
import 'package:adriel_flutter_app/NamerApp/NamerApp.dart';
import 'package:adriel_flutter_app/adaptable/ResizeablePage.dart';
import 'package:provider/provider.dart';
import 'communicator/communicator.dart';

void main() {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  } catch (error, stackTrace) {
    print('Caught error: $error');
    print(stackTrace);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData.light(), // Light mode theme
        darkTheme: ThemeData.dark(), // Dark mode theme
        themeMode: ThemeMode.system, // System theme mode
        home: MainApp(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var selectedIndex = 0;
  var selectedIndexHistory = [0];

  bool _isSafeAreaVisible = true;

  void _toggleSafeAreaVisibility() {
    setState(() {
      _isSafeAreaVisible = !_isSafeAreaVisible;
    });
  }

  double checkWidth(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 600) {
      return 180;
    } else {
      return MediaQuery.of(context).size.width * 0.2;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage(onMenuPressed: _toggleSafeAreaVisibility);
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = CommunicatorLogin();
        break;
      case 3:
        page = ResizeablePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize:
                MainAxisSize.min, // This makes the Row as small as possible
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: _toggleSafeAreaVisibility,
              ),
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (selectedIndexHistory.isNotEmpty) {
                    selectedIndexHistory.removeLast();
                    // selectedIndex = ;
                    setState(() {
                      selectedIndex = selectedIndexHistory.last;
                    });
                  }
                },
              ),
              Text('Adriel first flutter app'),
            ],
          ),
        ),
        body: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: _isSafeAreaVisible ? checkWidth(context) : 0,
              child: _isSafeAreaVisible
                  ? SafeArea(
                      child: NavigationRail(
                        extended: constraints.maxWidth >= 600,
                        destinations: [
                          NavigationRailDestination(
                            icon: Icon(Icons.home),
                            label: Text('Home'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.favorite),
                            label: Text('Favorites'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.login),
                            label: Text('Login'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.app_registration),
                            label: Text('App resize'),
                          ),
                        ],
                        selectedIndex: selectedIndex,
                        onDestinationSelected: (value) {
                          setState(() {
                            selectedIndex = value;
                            selectedIndexHistory.add(value);
                          });
                        },
                      ),
                    )
                  : null,
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}



