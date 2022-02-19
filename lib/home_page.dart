import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool ohTurn = true;

  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  var myTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 30,
  );

  var myNewFont = const TextStyle(
    color: Colors.black,
    letterSpacing: 3,
  );

  var myNewFontWhite = const TextStyle(
    color: Colors.white,
    letterSpacing: 3,
    fontSize: 15,
  );

  List<String> displayExOh = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == "") {
        displayExOh[index] = "0";
      } else if (!ohTurn && displayExOh[index] == "") {
        displayExOh[index] = "X";
      }

      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != "") {
      _showWinDialog(displayExOh[0]);
    }

    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != "") {
      _showWinDialog(displayExOh[3]);
    }

    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != "") {
      _showWinDialog(displayExOh[6]);
    }

    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != "") {
      _showWinDialog(displayExOh[0]);
    }

    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != "") {
      _showWinDialog(displayExOh[1]);
    }

    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != "") {
      _showWinDialog(displayExOh[2]);
    }

    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != "") {
      _showWinDialog(displayExOh[0]);
    }

    if (displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6] &&
        displayExOh[2] != "") {
      _showWinDialog(displayExOh[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Text("Play Again"),
              )
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("$winner Wins!"),
            actions: [
              TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Text("Play Again"),
              )
            ],
          );
        });
    if (winner == "0") {
      ohScore += 1;
    } else if (winner == "X") {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExOh[i] = "";
      }
    });
    filledBoxes = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Player X", style: myNewFontWhite),
                        Text(exScore.toString(), style: myNewFontWhite),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(exScore.toString(), style: myNewFontWhite),
                        Text(ohScore.toString(), style: myNewFontWhite),
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
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: const Color(0xFF616161),
                    )),
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
            child: Container(),
          ),
        ],
      ),
    );
  }
}
