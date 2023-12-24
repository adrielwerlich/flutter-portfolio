import 'package:adriel_flutter_app/doc_manager/doc_manager_login.dart';
import 'package:adriel_flutter_app/doc_manager/views/docs_router.dart';
import 'package:adriel_flutter_app/portfolio/portfolio.dart';
import 'package:adriel_flutter_app/state/app_state.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:adriel_flutter_app/NamerApp/NamerApp.dart';
import 'package:adriel_flutter_app/adaptable/ResizeablePage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart' as provider;
import 'package:adriel_flutter_app/snake_game/snake_game_web.dart'
    if (dart.library.io) 'package:adriel_flutter_app/snake_game/snake_game_non_web.dart';

import 'package:adriel_flutter_app/utils/save_origin_web.dart'
    if (dart.library.io) 'package:adriel_flutter_app/utils/save_origin_not_web.dart';



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
      provider.ChangeNotifierProvider(
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
    return provider.ChangeNotifierProvider(
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
  // rest-ask7cdmnk-adrielwerlich.vercel.app
  // static const baseUrl = kReleaseMode ? 'https://supabase-manager.vercel.app' : 'http://localhost:4876';
  static const baseUrl = 'https://supabase-manager.vercel.app';
  // static const baseUrl = 'http://localhost:4876';
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
    saveOrigin();
  }

  // void saveOrigin() async {
  //   var response = await http.get(Uri.parse('https://ipapi.co/json/'));
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     print('City: ${jsonResponse['city']}');
  //     print('Country: ${jsonResponse['country']}');
  //     print('Current date and time: ${DateTime.now()}');
  //     if (kIsWeb) {
  //       print('Running on the web');
  //     } else {
  //       print('OS: ${Platform.operatingSystem}');
  //       print('OS Version: ${Platform.operatingSystemVersion}');
  //       print('Dart Version: ${Platform.version}');
  //     }

  //     jsonResponse['datetime'] = DateTime.now().toIso8601String();
  //     if (kIsWeb) {
  //       jsonResponse['os'] = [
  //         html.window.navigator.appCodeName,
  //         html.window.navigator.appName,
  //         html.window.navigator.appVersion,
  //         html.window.navigator.language,
  //         html.window.navigator.onLine.toString(),
  //         html.window.navigator.platform,
  //         html.window.navigator.product,
  //         html.window.navigator.userAgent
  //       ].join(',');
  //       jsonResponse['osVersion'] = 'Not available';
  //       jsonResponse['dartVersion'] = 'Not available';
  //     } else {
  //       jsonResponse['os'] = Platform.operatingSystem;
  //       jsonResponse['osVersion'] = Platform.operatingSystemVersion;
  //       jsonResponse['dartVersion'] = Platform.version;
  //     }
  //     if (kIsWeb) {
  //       print('Running on web');
  //       jsonResponse['plataform'] = 'Running on web';
  //     } else if (Platform.isAndroid || Platform.isIOS) {
  //       print('Running on mobile');
  //       jsonResponse['plataform'] = 'Running on mobile';
  //     } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
  //       print('Running on desktop');
  //       jsonResponse['plataform'] = 'Running on desktop';
  //     }

  //     final url = Uri.parse('${MainApp.baseUrl}/request-origin');

  //     response = await http.post(
  //       url,
  //       body: jsonEncode(jsonResponse),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 200) {
  //       print('IP information saved!');
  //     } else {
  //       print('Failed to save IP information');
  //     }
  //   } else {
  //     print('Failed to get IP information');
  //   }
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
    final appState = provider.Provider.of<AppState>(context, listen: true);
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
              Text('Adriel flutter portfolio'),
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
                            icon: Icon(
                                appState.isLogged ? Icons.abc : Icons.login),
                            label:
                                Text(appState.isLogged ? 'Your docs' : 'Login'),
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
