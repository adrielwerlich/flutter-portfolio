import 'package:flutter/material.dart';
import 'projects.dart';

class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData.light(), // Light mode theme
      darkTheme: ThemeData.dark(), // Dark mode theme
      themeMode: ThemeMode.system, // System theme mode
      home: PortfolioPage(key: UniqueKey()),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  PortfolioPage({required Key key}) : super(key: key);

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  String getDeviceLanguage() {
    Locale? locale = Localizations.localeOf(context);
    return locale.languageCode == 'en' ? 'en' : 'pt';
  }

  List<Project> projects = Projects().loadJson();

  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        children: [
          Wrap(
            direction: Axis.horizontal,
            children: projects
                .where((project) => project.language == getDeviceLanguage())
                .map((project) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  height: 400, // Provide a height constraint for the Card
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          // leading: CircleAvatar(
                          //   backgroundImage:
                          //       AssetImage('assets/example-header-image.png'),
                          // ),
                          title: Text(project.title),
                          subtitle: Text('madeWith ${project.madeWith}'),
                        ),
                        Container(
                          constraints: BoxConstraints(
                              minHeight: 180,
                              maxHeight: 180), // Set the minimum height here
                          child: Image.asset(
                            project.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            constraints: BoxConstraints(
                                minHeight: 83), // Set the minimum height here
                            child: Text(
                              project.description,
                              style: TextStyle(height: 1.5),
                            ),
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            TextButton(
                              child: Text('View Project'),
                              onPressed: () => print(project.link),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.counter,
  });
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 420,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 51, 49, 49),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(10, 10),
            blurRadius: 20,
            // spreadRadius: 20,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Counter Example',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              counter.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            )
          ],
        ),
      ),
    );
  }
}
