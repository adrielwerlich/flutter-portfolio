import 'package:flutter/material.dart';
import 'package:adriel_flutter_app/communicator/communicator.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';


class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class GeneratorPage extends StatelessWidget {
  final VoidCallback onMenuPressed;

  GeneratorPage({required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(child: Text('A random COOL idea:')),
                    BigCard(pair: pair),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            appState.toggleFavorite();
                          },
                          icon: Icon(icon),
                          label: Text('Like'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            appState.getNext();
                          },
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CommunicatorLogin()));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            child: Text('Go to communicator login'),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: Color(Colors.red.shade100.value),
    );
    return Card(
      color: Color(Colors.red.shade900.value),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            pair.asLowerCase,
            style: style,
            semanticsLabel: "${pair.first} ${pair.second}",
          ),
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}
