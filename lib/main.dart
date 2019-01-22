import 'package:flutter/material.dart';
import './move_list.dart';

// TODO: move history
// TODO: determine winner

void main() => runApp(TicTacToe());

class TicTacToe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  String _currentPlayer;
  List<Map> _moveList;

  @override
  void initState() {
    _currentPlayer = '';
    _moveList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Column(
          children: <Widget>[
            TacGrid(
              currentPlayer: _currentPlayer,
              moveList: _moveList,
              savePlayerMove: _savePlayerMove,
              newGame: _newGame,
            ),
            // MoveList()
          ],
        ),
      ),
    );
  }

  void _savePlayerMove(int rowIndex, int colIndex, String player) {
    setState(() {
      _currentPlayer = player == 'X' ? 'O' : 'X';
    });

    _moveList.add(
        {'player': _currentPlayer, 'rowIndex': rowIndex, 'colIndex': colIndex});

    // if (_moveList.length >= 5) {
    _calculateWinner(_moveList);
    // }
  }

  void _calculateWinner(List<Map> moves) {
    
    print('======');
    final List lines = [
      // HORIZONTALS
      [0, 0], [0, 1], [0, 2],
      [1, 0], [1, 1], [1, 2],
      [2, 0], [2, 1], [2, 2],
      // DIAGONALS
      [0, 0], [1, 1], [2, 2],
      [0, 2], [1, 1], [2, 0],
      // VERTICALS
      [0, 0], [1, 0], [2, 0],
      [0, 1], [1, 1], [2, 1],
      [0, 2], [1, 2], [2, 2],
    ];

    List<Map> xMoves = moves.where((move) => move['player'] == _currentPlayer).toList();

    // xMoves.retainWhere((move) => move['player'] == _currentPlayer);

    // List<Map> xMoves = new List.from(moves);
    // xMoves.retainWhere((move) => move['player'] == _currentPlayer);

    print(xMoves);


    moveLoop:
    for (var move in xMoves) {
      print('move=> $move');
      
      int counter = 0;

      lineLoop:
      for (var line in lines) {
        if (move['rowIndex'] == line[0] && move['colIndex'] == line[1]) {
          print('line=> $line');
          counter++;
        }
      }
    }

    print('======');
  }

  void _newGame() {
    setState(() {
      _currentPlayer = '';
      _moveList.clear();
    });
  }
}

class TacGrid extends StatelessWidget {
  final String currentPlayer;
  final List<Map> moveList;
  final Function savePlayerMove;
  final Function newGame;

  TacGrid(
      {this.currentPlayer, this.moveList, this.savePlayerMove, this.newGame});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Center(child: Text('X: 0'))),
            Expanded(
                child: RaisedButton(
              child: Text('New Game'),
              onPressed: () => this.newGame(),
            )),
            Expanded(child: Center(child: Text('O: 0'))),
          ],
        ),
        TacRow(
            rowIndex: 0,
            currentPlayer: this.currentPlayer,
            moveList: this.moveList,
            savePlayerMove: this.savePlayerMove),
        TacRow(
            rowIndex: 1,
            currentPlayer: this.currentPlayer,
            moveList: this.moveList,
            savePlayerMove: this.savePlayerMove),
        TacRow(
            rowIndex: 2,
            currentPlayer: this.currentPlayer,
            moveList: this.moveList,
            savePlayerMove: this.savePlayerMove),
      ],
    );
  }
}

class TacRow extends StatelessWidget {
  final int rowIndex;
  final String currentPlayer;
  final List<Map> moveList;
  final Function savePlayerMove;

  TacRow(
      {this.rowIndex, this.currentPlayer, this.moveList, this.savePlayerMove});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TacCell(
          rowIndex: this.rowIndex,
          colIndex: 0,
          currentPlayer: this.currentPlayer,
          moveList: this.moveList,
          savePlayerMove: this.savePlayerMove,
        ),
        TacCell(
          rowIndex: this.rowIndex,
          colIndex: 1,
          currentPlayer: this.currentPlayer,
          moveList: this.moveList,
          savePlayerMove: this.savePlayerMove,
        ),
        TacCell(
          rowIndex: this.rowIndex,
          colIndex: 2,
          currentPlayer: this.currentPlayer,
          moveList: this.moveList,
          savePlayerMove: this.savePlayerMove,
        ),
      ],
    );
  }
}

class TacCell extends StatelessWidget {
  final int rowIndex;
  final int colIndex;
  final String currentPlayer;
  final List<Map> moveList;
  final Function savePlayerMove;

  TacCell(
      {this.rowIndex,
      this.colIndex,
      this.currentPlayer,
      this.moveList,
      this.savePlayerMove});

  @override
  Widget build(BuildContext context) {
    String _cellText = '';
    Color _colorPlayer;
    loop:
    for (var move in this.moveList) {
      if (this.rowIndex == move['rowIndex'] &&
          this.colIndex == move['colIndex']) {
        _cellText = move['player'];
        _colorPlayer =
            (move['player'] == 'X' ? Colors.cyan[100] : Colors.green[50]);
        break loop;
      }
    }

    Function _cellPress() {
      if (_cellText == '') {
        return () {
          this.savePlayerMove(this.rowIndex, this.colIndex, this.currentPlayer);
        };
      } else {
        return null;
      }
    }

    return Expanded(
      child: RaisedButton(
          disabledColor: _colorPlayer,
          child: Text(_cellText),
          onPressed: _cellPress()),
    );
  }
}
