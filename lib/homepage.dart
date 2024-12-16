import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true; // first player is O!
  List<String> displayExOh = List.filled(9, '');

  var myTextStyle = const TextStyle(color: Colors.white, fontSize: 30);
  int ohScore=0;
  int exScore=0;
  int filledBoxes=0;

  var myFontStyle = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontFamily: 'Rubik',
  );


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Player O', style: myFontStyle,),
                          Text(ohScore.toString(), style: myFontStyle,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Player X', style: myFontStyle,),
                          Text(exScore.toString(), style: myFontStyle,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9, // Specify item count
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey[700] ?? Colors.blueGrey, // Provide a fallback color
                        ),
                      ),
                      child: Center(
                        child: Text(
                          displayExOh[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Text('TIC TAC TOE', style: myFontStyle,),
                      SizedBox(height: 60,),
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

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'O';
        filledBoxes += 1;
      } else if (!ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'X';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      _showWinDialogue(displayExOh[0]);
    } else if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      _showWinDialogue(displayExOh[3]);
    } else if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      _showWinDialogue(displayExOh[6]);
    } else if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      _showWinDialogue(displayExOh[0]);
    } else if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      _showWinDialogue(displayExOh[1]);
    } else if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      _showWinDialogue(displayExOh[2]);
    } else if (displayExOh[6] == displayExOh[4] &&
        displayExOh[6] == displayExOh[2] &&
        displayExOh[6] != '') {
      _showWinDialogue(displayExOh[0]);
    } else if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showWinDialogue(displayExOh[2]);
    }
    else if(filledBoxes == 9) {
      _showDrawDialogue();
    }
  }

  void _showDrawDialogue() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('DRAW!'),
          actions: [
            FilledButton(
              child: Text('Play Again'),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showWinDialogue(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Winner is: $winner'),
          actions: [
            FilledButton(
              child: Text('Play Again'),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    if(winner == 'O'){
      ohScore += 1;
    }
    else if(winner == 'X'){
      exScore += 1;
    }
  }
  void _clearBoard(){
    setState(() {
      for(int i=0; i<9; i++) {
        displayExOh[i] = '' ;
      }
    });
    filledBoxes = 0;
  }
}


