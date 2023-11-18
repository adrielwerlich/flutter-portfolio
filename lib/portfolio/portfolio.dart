import 'package:flutter/material.dart';
import 'package:adriel_flutter_app/portfolio/stack_card/swipeable-card.dart';
import 'package:flutter_stack_card/flutter_stack_card.dart';

import 'package:adriel_flutter_app/portfolio/stack_card/swipeable-card.dart';

import 'movie.dart';

class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stack Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PortfolioPage(title: 'Flutter Stack Card', key: UniqueKey()),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  PortfolioPage({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  List<Movie> _movieData = Movie().movieData;
  var width, height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: StackCard.builder(
              displayIndicator: true,
              displayIndicatorBuilder:
                  IdicatorBuilder(displayIndicatorActiveColor: Colors.blue),
              itemCount: _movieData.length,
              onSwap: (index) {
                print("Page change to $index");
              },
              itemBuilder: (context, index) {
                Movie movie = _movieData[index];
                return _itemBuilder(movie);
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TinderSwapCard(
                maxWidth: 120,
                maxHeight: 120,
                minWidth: 100,
                minHeight: 100,
                stackNum: 3,
                totalNum: 10,
                swipeEdge: 4.0,
                swipeEdgeVertical: 4.0,
                allowVerticalMovement: true,
                swipeUp: true,
                swipeDown: true,
                animDuration: 800,
                cardBuilder:
                    (BuildContext context, int index, double currentPos) {
                  // Build your card widget here
                  return Container(
                    height: 200,
                    width: 200,
                    color: Colors.blue,
                    child: Text('Card $index'),
                  );
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                  // Handle swipe complete event here
                  if (orientation == CardSwipeOrientation.LEFT) {
                    print('Swiped left on card $index');
                  } else if (orientation == CardSwipeOrientation.RIGHT) {
                    print('Swiped right on card $index');
                  } else if (orientation == CardSwipeOrientation.UP) {
                    print('Swiped up on card $index');
                  } else if (orientation == CardSwipeOrientation.DOWN) {
                    print('Swiped down on card $index');
                  } else if (orientation == CardSwipeOrientation.RECOVER) {
                    print('Recovered card $index');
                  }
                },
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  // Handle swipe update event here
                  print(
                      'Swipe update: dx=${details.delta.dx}, dy=${details.delta.dy}');
                },
                cardController: CardController(),
              )),
        ],
      ),
    );
  }

  Widget _itemBuilder(Movie movie) {
    return Container(
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white),
        ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: height * .3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                        image: ExactAssetImage(movie.image),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: height * .45,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 150,
                            child: Text(
                              movie.title,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 24),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(height: 4),
                              Text(
                                movie.display,
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "IMDB: ${movie.imdb.toString()}",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(movie.gendres,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(movie.desc,
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      Center(
                        child: IconButton(
                            icon: Icon(Icons.drag_handle, color: Colors.grey),
                            onPressed: () {}),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
