import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'dart:html' if (dart.library.html) 'dart:html' as html;

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  late int squaresPerRow;
  late int squaresPerCol;
  late TextStyle fontStyle;
  final randomGen = Random();
  Timer? timer;
  bool isPaused = false;
  late FocusNode focusNode;
  late Duration duration;
  bool _isLoading = true;

  late List<int> snakePosition;
  int food = 300;
  String direction = 'down';
  var gameStatus = 'Press arrow keys to start';

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    loadMyWidget();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fontStyle = TextStyle(
        fontSize: 20,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white);
    squaresPerRow = (MediaQuery.of(context).size.width / 20).floor();
    squaresPerCol = (MediaQuery.of(context).size.height / 20).floor();

    // Set the initial snake position to the top left corner
    snakePosition = [
      0,
      squaresPerRow,
      2 * squaresPerRow,
      3 * squaresPerRow,
      4 * squaresPerRow,
    ];
  }

  void startGame() {
    // const initialDuration = Duration(milliseconds: 300);
    duration = Duration(milliseconds: 300);

    timer = Timer.periodic(duration, (Timer timer) {
      if (isPaused) return;
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen();
      }
    });

    html.window.onKeyDown.listen((html.KeyboardEvent event) {
      // print('Key pressed: ${event.key}');
      if (event.key == "Escape") {
        setState(() {
          isPaused = !isPaused;
        });
      }
      if (event.key == "ArrowUp") {
        if (direction != 'down') {
          setState(() {
            pendingDirection = 'up';
          });
        }
      }
      if (event.key == "ArrowDown") {
        if (direction != 'up') {
          setState(() {
            pendingDirection = 'down';
          });
        }
      }
      if (event.key == "ArrowLeft") {
        if (direction != 'right') {
          setState(() {
            pendingDirection = 'left';
          });
        }
      }
      if (event.key == "ArrowRight") {
        if (direction != 'left') {
          setState(() {
            pendingDirection = 'right';
          });
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    focusNode.dispose();
    super.dispose();
  }

  var pendingDirection = 'down';
  void updateSnake() {
    if (!mounted) return;
    setState(() {
      direction = pendingDirection;

      switch (direction) {
        case 'up':
          if (snakePosition.last - squaresPerRow >= 0) {
            snakePosition.add(snakePosition.last - squaresPerRow);
          } else {
            snakePosition
                .add(snakePosition.last + squaresPerRow * (squaresPerCol - 1));
          }
          break;

        case 'down':
          if (snakePosition.last + squaresPerRow <
              squaresPerRow * squaresPerCol) {
            snakePosition.add(snakePosition.last + squaresPerRow);
          } else {
            snakePosition.add(snakePosition.last % squaresPerRow);
          }
          break;

        case 'left':
          if (snakePosition.last % squaresPerRow > 0) {
            snakePosition.add(snakePosition.last - 1);
          } else {
            snakePosition.add(snakePosition.last + squaresPerRow - 1);
          }
          break;

        case 'right':
          if (snakePosition.last % squaresPerRow < squaresPerRow - 1) {
            snakePosition.add(snakePosition.last + 1);
          } else {
            snakePosition.add(snakePosition.last - squaresPerRow + 1);
          }
          break;

        default:
          break;
      }

      if (snakePosition.last == food) {
        generateNewFood();
        if (duration.inMilliseconds > 50) {
          duration -= const Duration(milliseconds: 10);
        }
        timer?.cancel();
        timer = Timer.periodic(duration, (Timer timer) {
          if (isPaused) return;
          updateSnake();
          if (gameOver()) {
            timer.cancel();
            _showGameOverScreen();
          }
        });
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void generateNewFood() {
    food = randomGen.nextInt(squaresPerRow * squaresPerCol);
  }

  void _showGameOverScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Score: ${snakePosition.length - 5}'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  snakePosition = [45, 65, 85, 105, 125];
                  food = 300;
                  direction = 'down';
                  gameStatus = 'Press arrow keys to start';
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> loadMyWidget() async {
    // Simulate a delay of 2 seconds while your widget is loading.
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Focus(
          child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (direction != 'up' && details.delta.dy > 0) {
                    pendingDirection = 'down';
                  } else if (direction != 'down' && details.delta.dy < 0) {
                    pendingDirection = 'up';
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (direction != 'left' && details.delta.dx > 0) {
                    pendingDirection = 'right';
                  } else if (direction != 'right' && details.delta.dx < 0) {
                    pendingDirection = 'left';
                  }
                },
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: squaresPerRow * squaresPerCol,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: squaresPerRow,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (snakePosition.contains(index)) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      );
                    }
                    if (index == food) {
                      return Container(
                        padding: EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Colors.grey[900],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: startGame,
                    child: Text(
                      "Start",
                      style: fontStyle,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: generateNewFood,
                    child: Text(
                      "No food",
                      style: fontStyle,
                    ),
                  ),
                  Text(
                    'Score: ${snakePosition.length - 5}',
                    style: fontStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    }
  }
}
