import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';
import 'dart:math';

import 'utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final vert_padding = MediaQuery.of(context).padding.top;

    final appBar = AppBar(
      title: Text("Chessmoves"),
    );

    final bodyHeight = min(size.width, size.height - appBar.preferredSize.height - vert_padding);

    final chessboard = Chessboard(
      fen: _fen,
      size: bodyHeight,
      onMove: (move) {
        final nextFen = makeMove(_fen, {
          'from': move.from,
          'to': move.to,
          'promotion': 'q',
        });
        if (nextFen != null) {
          setState(() {
            _fen = nextFen;
          });
          Future.delayed(Duration(milliseconds: 500)).then((_) {
            final nextMove = getRandomMove(_fen);
            if (nextMove != null) {
              setState(() {
                _fen = makeMove(_fen, nextMove);
              });
            }
          });
        }
      },
    );

    final display = Container(
      width: 50,
      color: Colors.amber[600]
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            chessboard,
            display
          ]
        )
      ),
    );
  }
}
