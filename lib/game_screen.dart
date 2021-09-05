import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'board.dart';
import 'package:flutter/services.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  final int num_block = 100;
  final int timerWalker = 300;
  int block_walk_p1;
  int block_walk_p2;
  int one_numberDice = 0;
  int second_numberDice = 0;

  bool player_1 = true;

  final List snake_head = [48, 43, 85];
  final List snake_tail = [17, 11, 52];
  final List ladder_top = [97];
  final List ladder_bottom = [67];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restartGame();
  }

  void restartGame() {
    setState(() {
      block_walk_p1 = 0;
      block_walk_p2 = 0;
      one_numberDice = 0;
      second_numberDice = 0;
    });
  }

  int verifyStopSnakeHead(int block) {
    for (int i = 0; i < snake_head.length; i++) {
      if (block == snake_head[i]) {
        showdialogStopSnake();
        block = snake_tail[i];
      }
    }
    return block;
  }

  int verifyStopLadderBottom(int block) {
    for (int i = 0; i < ladder_bottom.length; i++) {
      if (block == ladder_bottom[i]) {
        AlertDialog(

        );
        block = ladder_top[i];
      }
    }
    return block;
  }

  // void playerWalk_p1(int totalNumberDice) {
  //   var count = block_walk_p1 - totalNumberDice;
  //   final Stream myStream =
  //   new Stream.periodic(Duration(milliseconds: timerWalker), (_) => count++);
  //
  //   myStream.map((val) {
  //     setState(() {
  //       block_walk_p1 = count;
  //     });
  //     return val;
  //   }).take(block_walk_p1 - count).forEach((e) {
  //     setState(() {
  //       block_walk_p1 = count;
  //     });
  //   });
  // }
  //
  // void playerWalk_p2(int totalNumberDice) {
  //   var count = block_walk_p2 - totalNumberDice;
  //   final Stream myStream =
  //   new Stream.periodic(Duration(milliseconds: timerWalker), (_) => count++);
  //
  //   myStream.map((val) {
  //     setState(() {
  //       block_walk_p2 = count;
  //     });
  //     return val;
  //   }).take(block_walk_p2 - count).forEach((e) {
  //     setState(() {
  //       block_walk_p2 = count;
  //     });
  //   });
  // }

  void rulesPlayerOne() {
    var dice = new Random();
    one_numberDice = dice.nextInt(6) + 1;
    second_numberDice = dice.nextInt(6) + 1;

    if (one_numberDice == second_numberDice) {
      player_1 = true;
    } else {
      player_1 = false;
    }

    int totalNumberDice = one_numberDice + second_numberDice;

    block_walk_p1 = block_walk_p1 + totalNumberDice;

    // verify number block is 100 ? turn block
    if (block_walk_p1 > num_block) {
      int block_turn = block_walk_p1 - num_block;
      block_walk_p1 = num_block;
      block_walk_p1 = block_walk_p1 - block_turn;
    } else if (block_walk_p1 == num_block) {
      block_walk_p1 = num_block;
      showdialogWin("Jogador 1 venceu o jogo");
    }

    block_walk_p1 = verifyStopSnakeHead(block_walk_p1);

    block_walk_p1 = verifyStopLadderBottom(block_walk_p1);

    //playerWalk_p1(totalNumberDice);
  }

  void rulesPlayerTwo() {
    var dice = new Random();
    one_numberDice = dice.nextInt(6) + 1;
    second_numberDice = dice.nextInt(6) + 1;

    if (one_numberDice == second_numberDice) {
      player_1 = false;
    } else {
      player_1 = true;
    }

    int totalNumberDice = one_numberDice + second_numberDice;

    block_walk_p2 = block_walk_p2 + totalNumberDice;
    block_walk_p2 = verifyStopLadderBottom(block_walk_p2);

    // verify number block is 100 ? turn block
    if (block_walk_p2 > num_block) {
      int block_turn = block_walk_p2 - num_block;
      block_walk_p2 = num_block;
      block_walk_p2 = block_walk_p2 - block_turn;
    } else if (block_walk_p2 == num_block) {
      block_walk_p2 = num_block;
      showdialogWin("Jogador 2 venceu o jogo");
    }

    block_walk_p2 = verifyStopSnakeHead(block_walk_p2);

    //playerWalk_p2(totalNumberDice);
  }

  void playDices() {
    if (player_1) {
      rulesPlayerOne();
    } else {
      rulesPlayerTwo();
    }
  }

  showdialogWin(String playerWin) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "O jogo acabou!",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  playerWin,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    restartGame();
                  });
                },
                child: Text(
                  "Recomeçar",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        });
  }

  showdialogStopSnake() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Você caiu na cabeça de uma cobra!",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sssshhhhh!!!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Continuar",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        });
  }

  _createObject(double top, double left, String image) {
    return Positioned(
      top: top,
      left: left,
      child: Image.asset(
        image,
        height: 150,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Snake & Stairs"),
        actions: [
          IconButton(
              icon: Icon(Icons.rotate_left),
              onPressed: restartGame,
              color: Colors.black),
        ],
      ),
      body: Container(
        color: Colors.green,
        child: Column(
          children: [
            Stack(
              children: [
                // create board
                Board(num_block, block_walk_p1, block_walk_p2),
                // create snake green
                _createObject(220, 95, "assets/snake_1.png"),
                // create snake red
                _createObject(50, 200, "assets/snake_2.png"),
                // create snake blue
                _createObject(207, 300, "assets/snake_3.png"),
                // create ladder
                _createObject(10, 115, "assets/ladder1.png"),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/table.jpg"),
                      fit: BoxFit.fill,
                  )
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      player_1
                          ? Text(
                              "Jogador 1 sua vez",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                            )
                          : Text(
                              "Jogador 2 sua vez ",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset("assets/dice_${one_numberDice}.png"),
                          ElevatedButton(
                            child: Text("Jogar"),
                            onPressed: () {
                                setState(() {
                                  playDices();
                                });
                            },
                          ),
                          Image.asset("assets/dice_${second_numberDice}.png"),
                        ],
                      ),
                      Text(
                        "Jogador 1 esta na casa ${block_walk_p1}",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        "Jogador 2 esta na casa ${block_walk_p2}",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
