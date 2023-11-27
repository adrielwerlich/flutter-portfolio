import 'package:adriel_flutter_app/doc_manager/doc_manager_login.dart';
import 'package:adriel_flutter_app/doc_manager/views/docs_screen.dart';
import 'package:adriel_flutter_app/portfolio/portfolio.dart';
import 'package:adriel_flutter_app/snake_game/snake_game.dart';
import 'package:flutter/material.dart';
import 'package:adriel_flutter_app/NamerApp/NamerApp.dart';
import 'package:adriel_flutter_app/adaptable/ResizeablePage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'communicator/communicator.dart';
import 'package:adriel_flutter_app/communicator/messages.dart';

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
  bool isLogged = false;
  bool _isSafeAreaVisible = true;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      isLogged = loggedIn;
    });
  }

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

  // void gotoCommunicator() {
  //   setState(() {
  //     selectedIndex = 4;
  //     selectedIndexHistory.add(4);
  //     isLogged = true;
  //   });
  // }

  void gotoDocs() {
    setState(() {
      // selectedIndex = 5;
      // selectedIndexHistory.add(5);
      isLogged = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    // if (selectedIndex == 1 && isLogged) {
    //   selectedIndex = 4;
    // }
    // else {
    //   page = NamerApp();
    // }
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        // page = CommunicatorLogin(gotoChatPage: gotoCommunicator);
        if (isLogged) {
          page = DocumentListPage();
        } else {
          page = DocManagerLogin(gotoDocsPage: gotoDocs);
        }
        break;
      case 2:
        page = ResizeablePage();
        break;
      case 3:
        page = Portfolio();
        break;
      case 4:
        page = SnakeGame();
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
                            icon: Icon(Icons.login),
                            label: Text('Login'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.app_registration),
                            label: Text('App resize'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.dashboard),
                            label: Text('Portfolio'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.gamepad),
                            label: Text('SnakeGame'),
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
