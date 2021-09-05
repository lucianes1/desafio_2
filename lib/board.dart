import 'dart:math';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {

  final int num_block;
  final int block_walk_p1;
  final int block_walk_p2;

  Board(this.num_block, this.block_walk_p1, this.block_walk_p2);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {

  final List colors = [Colors.red[200], Colors.blue[200], Colors.yellow[200]];

  // void changeColorBoard() {
  //   indexColor = color.nextInt(colors.length);
  // }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: 1,
      crossAxisCount: 10,
      children: List.generate(widget.num_block, (index) {
        int number = widget.num_block;
        return Container(
          margin: EdgeInsets.all(2),
          color: index % 3 == 0 ? colors[0] :  colors[2],
          child: Stack(
            children: [
              number - index == widget.block_walk_p1
                  ? Image.asset("assets/player1.png")
                  : Text(
                (number - index).toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              number - index == widget.block_walk_p2
                  ? Image.asset("assets/player2.png")
                  : Text(
                (number - index).toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        );
      },
      ),
    );
  }
}
