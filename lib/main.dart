import 'package:adriel_flutter_app/doc_manager/doc_manager_login.dart';
import 'package:adriel_flutter_app/doc_manager/views/docs_router.dart';
import 'package:adriel_flutter_app/doc_manager/views/documents_list_page.dart';
import 'package:adriel_flutter_app/portfolio/portfolio.dart';
import 'package:adriel_flutter_app/snake_game/snake_game.dart';
import 'package:adriel_flutter_app/state/app_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:adriel_flutter_app/NamerApp/NamerApp.dart';
import 'package:adriel_flutter_app/adaptable/ResizeablePage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'communicator/communicator.dart';
// import 'package:adriel_flutter_app/communicator/messages.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory(),
    );
    // runApp(MyApp());
    runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MyApp(),
    ),
  );
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
        title: 'Adriel flutter app',
        theme: ThemeData.light(), // Light mode theme
        darkTheme: ThemeData.dark(), // Dark mode theme
        themeMode: ThemeMode.system, // System theme mode
        home: MainApp(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  static const baseUrl = 'http://localhost:4876';
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var selectedIndex = 0;
  var selectedIndexHistory = [0];
  // bool isLogged = false;
  bool _isSafeAreaVisible = true;

  @override
  void initState() {
    super.initState();
    // checkLoginStatus();
  }

  // void checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
  //   setState(() {
  //     isLogged = loggedIn;
  //   });
    
  //   if (!loggedIn) {
  //     // Perform logout actions here
  //     // For example, you can reset the selectedIndex and selectedIndexHistory
  //     setState(() {
  //       selectedIndex = 0;
  //       selectedIndexHistory.clear();
  //     });
  //   }
  // }

  // void onLogout() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isLoggedIn', false);
  //   setState(() {
  //     isLogged = false;
  //   });
  // }

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
    final appState = Provider.of<AppState>(context, listen: true);
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        if (appState.isLogged) {
          page = DocsRouter();
        } else {
          page = DocManagerLogin();
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
                            icon: Icon(appState.isLogged ? Icons.abc : Icons.login),
                            label: Text(appState.isLogged ? 'Your docs' : 'Login'),
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
