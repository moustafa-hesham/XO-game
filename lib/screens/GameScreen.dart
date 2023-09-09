import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xo_app/constants.dart';
import 'package:xo_app/widgets/CustomButton.dart';
import 'package:xo_app/widgets/buttons.dart';

import '../models/gameBoardArguments.dart';

class GameScreen extends StatefulWidget {
  static String iD = 'game screen';
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = ['', '', '', '', '', '', '', '', ''];

  int counter = 0;
  int player1Score = 0;
  int player2Score = 0;

  TextStyle playerNameTextStyle = const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    GameBoardArguments args =
        ModalRoute.of(context)!.settings.arguments as GameBoardArguments;
    //lazm gowa el build
    // el as dih esmaha Casting
    String player1Name = args.player1Name;
    String player2Name = args.player2Name;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    'Turn:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  playerTurn() ? player1Name : player2Name,
                  style: TextStyle(
                      color: playerTurn() ? kXColor : kOColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$player1Name: $player1Score',
                style: playerNameTextStyle,
              ),
              Text(
                '$player2Name: $player2Score',
                style: playerNameTextStyle,
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return Buttons(
                symbolColor: symbolColor(board[index]),
                index: index,
                symbols: board[index],
                onClick: (index) {
                  onButtonClick(index, player1Name, player2Name);
                },
              );
            },
          ),
          Row(
            children: [
              CustomButton(
                text: 'Rest Game',
                color: Colors.green,
                submit: () {
                  restBoard();
                },
              ),
              CustomButton(
                text: 'Restart Game',
                color: Colors.red,
                submit: () {
                  restBoard();
                  player1Score = 0;
                  player2Score = 0;
                },
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                  text: 'Exit',
                  color: Colors.black,
                  submit: () {
                    Navigator.pop(context);
                  })
            ],
          )
        ],
      ),
    );
  }

  onButtonClick(int index, String playerXName, String playerOName) {
    if (board[index].isNotEmpty) return;
    String symbol = counter % 2 == 0 ? "X" : 'O';
    board[index] = symbol;
    counter++;
    if (checkWinner(symbol)) {
      if (symbol == 'X') {
        player1Score++;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: 'Play Again',
          title: '$playerXName WON',
          btnOkOnPress: () {
            restBoard();
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: 'Play Again',
          title: '$playerOName WON',
          btnOkOnPress: () {
            restBoard();
          },
        ).show();
        player2Score++;
      }
      restBoard();
      return;
    }
    if (counter == 9) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        btnOkText: 'Play Again',
        title: 'Tie !',
        btnOkOnPress: () {
          restBoard();
        },
      ).show();
      restBoard();
    }

    setState(() {});
  }

  void restBoard() {
    board = ['', '', '', '', '', '', '', '', ''];
    counter = 0;
    setState(() {});
  }

  bool checkWinner(String symbol) {
    //Check winners in rows
    for (int i = 0; i <= 6; i += 3) {
      if (board[i] == symbol &&
          board[i + 1] == symbol &&
          board[i + 2] == symbol) {
        return true;
      }
    }
    //Check winners in columns
    for (int i = 0; i <= 2; i++) {
      if (board[i] == symbol &&
          board[i + 3] == symbol &&
          board[i + 6] == symbol) {
        return true;
      }
    }
    if (board[0] == symbol && board[4] == symbol && board[8] == symbol) {
      return true;
    }
    if (board[2] == symbol && board[4] == symbol && board[6] == symbol) {
      return true;
    }
    return false;
  }

  Color symbolColor(String symbol) {
    if (symbol == "X") {
      Color color = kXColor;
      return color;
    } else {
      {
        Color color = kOColor;
        return color;
      }
    }
  }

  bool playerTurn() {
    String symbol = counter % 2 == 0 ? "X" : 'O';
    if (symbol == 'X') {
      return true;
    } else {
      return false;
    }
  }
}
