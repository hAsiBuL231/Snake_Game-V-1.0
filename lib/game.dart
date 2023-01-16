import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'internal/globals.dart';

enum Direction { up, down, left, right }

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  Direction direction = Direction.down;
  var random = Random();
  int fruit = 10;
  int score = 0;
  var snakePosition = [0, 20, 40];

  startGame() {
    Future.delayed(Duration(milliseconds: gLevel), () {
      setState(() {
        snakeMovement();
        if (snakePosition.contains(fruit)) {
          fruit = random.nextInt(grow * gColumn);
          score++;
        }
        final copyList = List.from(snakePosition);
        if (snakePosition.length > copyList.toSet().length) {
          gameOver();
        }
      });
    });
  }

  gameOver() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Game Over"),
              content: Text("Your Score is: $score"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const GamePage();
                      }));
                    },
                    child: const Text("Try Again")),
                TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text("Exit"))
              ]);
        });
  }

  snakeMovement() {
    switch (direction) {
      case Direction.up:
        if (snakePosition.last < grow) {
          if (gBox == 'Closed') {
            gameOver();
          }
          snakePosition.add(snakePosition.last + grow * gColumn);
        } else {
          snakePosition.add(snakePosition.last - grow);
        }
        break;
      case Direction.down:
        if (snakePosition.last > grow * gColumn) {
          if (gBox == 'Closed') {
            gameOver();
          }
          snakePosition.add(snakePosition.last - grow * gColumn);
        } else {
          snakePosition.add(snakePosition.last + grow);
        }
        break;
      case Direction.left:
        if (snakePosition.last % grow == 0) {
          if (gBox == 'Closed') {
            gameOver();
          }
          snakePosition.add(snakePosition.last + grow - 1);
        } else {
          snakePosition.add(snakePosition.last - 1);
        }
        break;
      case Direction.right:
        if ((snakePosition.last + 1) % grow == 0) {
          if (gBox == 'Closed') {
            gameOver();
          }
          snakePosition.add(snakePosition.last - grow + 1);
        } else {
          snakePosition.add(snakePosition.last + 1);
        }
        break;
    }
    if (!snakePosition.contains(fruit)) {
      snakePosition.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    int profileH = MediaQuery.of(context).size.height.toInt();
    int profileW = MediaQuery.of(context).size.width.toInt();
    startGame();
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(children: [
            Container(
                padding: const EdgeInsets.all(3),
                color: Colors.amber,
                child: Text("Score: $score",
                    style: const TextStyle(fontSize: 18))),
            GestureDetector(
              onDoubleTap: startGame(),
              onVerticalDragUpdate: (details) {
                if (direction != Direction.up && details.delta.dy > 0) {
                  direction = Direction.down;
                }
                if (direction != Direction.down && details.delta.dy < 0) {
                  direction = Direction.up;
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != Direction.left && details.delta.dx > 0) {
                  direction = Direction.right;
                }
                if (direction != Direction.right && details.delta.dx < 0) {
                  direction = Direction.left;
                }
              },
              child: Container(
                  height: profileH.toDouble() - 70,
                  width: profileW.toDouble(),
                  color: Colors.black,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      itemCount: grow * gColumn,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: grow,
                        //mainAxisSpacing: 0.5,
                        //crossAxisSpacing: 0.5,
                      ),
                      itemBuilder: (contex, index) {
                        if (snakePosition.last == index) {
                          return Container(color: Colors.green[900]);
                        } else if (snakePosition.first == index) {
                          return Container(color: Colors.green[300]);
                        } else if (snakePosition.contains(index)) {
                          return Container(color: Colors.green);
                        } else if (index == fruit) {
                          return Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/egg.jpeg'),
                                      fit: BoxFit.fill),
                                  shape: BoxShape.rectangle,
                                  color: Colors.white));
                        } else {
                          return Container(color: Colors.white);
                        }
                      })),
            )
          ]),
        ),
        backgroundColor: Colors.blue[100]);
  }
}
