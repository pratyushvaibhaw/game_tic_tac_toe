import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/colors.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int xScore = 0;
  int oScore = 0;
  int attempt = 0;
  int filledBoxes = 0;
  String winner = '';
  List<String> xo = ['', '', '', '', '', '', '', '', ''];
  List<int> matchIndex = [];
  String result = '';
  bool winnerFound = false;
  bool xTurn = true; //x will always be first;
// functionality for timer--
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  static var font1 = GoogleFonts.coiny(
      textStyle:
          TextStyle(fontSize: 20, letterSpacing: .5, color: Colors.white));
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0)
          seconds--;
        else
          stopTimer();
      });
    });
  }

  void stopTimer() {
    resetTime();
    timer?.cancel();
  }

  void resetTime() => seconds = maxSeconds;
//functionality for timer ends;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 10,
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player X',
                        style: font1,
                      ),
                      Text(
                        xScore.toString(),
                        style: font1,
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player O',
                        style: font1,
                      ),
                      Text(
                        oScore.toString(),
                        style: font1,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(flex: 3, child: gameBoard()),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    result,
                    style: font1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 8,
                  ),
                  buildTimer(),
                ],
              ))
        ],
      ),
    );
  }

  GridView gameBoard() {
    return GridView.builder(
      physics: ScrollPhysics(),
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 3, mainAxisSpacing: 3, crossAxisCount: 3),
      itemBuilder: (BuildContext, index) {
        return GestureDetector(
          onTap: () {
            print(index);
            _logic(index);
          },
          child: Card(
            shadowColor: Colors.black,
            elevation: 50,
            child: buttons(index),
            borderOnForeground: false,
            shape:
                CircleBorder(side: BorderSide(color: AppColor.secondaryColor)),
          ),
        );
      },
      itemCount: 9,
    );
  }

  Container buttons(int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      margin: EdgeInsets.all(0),
      child: Center(
        child: Text(
          xo[index],
          style: GoogleFonts.coiny(
              textStyle: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationThickness: .40,
                  decorationStyle: TextDecorationStyle.wavy,
                  decorationColor: matchIndex.contains(index)
                      ? AppColor.tertiaryColor
                      : AppColor.accentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 60,
                  color: matchIndex.contains(index)
                      ? AppColor.tertiaryColor
                      : AppColor.accentColor)),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.secondaryColor, width: 2),
        color: matchIndex.contains(index)
            ? AppColor.secondaryColor
            : AppColor.tertiaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void _logic(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (xTurn && xo[index] == '') {
          xo[index] = 'X';
          filledBoxes++;
        } else if (!xTurn && xo[index] == '') {
          xo[index] = 'O';
          filledBoxes++;
        }
        xTurn = !xTurn;
        gameResult();
      });
    }
  }

  void gameResult() {
    //first row check
    if (!winnerFound && xo[0] != '' && xo[0] == xo[1] && xo[1] == xo[2]) {
      setState(() {
        result = 'Player ' + xo[0] + ' wins';
        matchIndex.addAll([0, 1, 2]);
        stopTimer();
        updateScore(xo[0]);
      });
    }
    if (!winnerFound && xo[0] != '' && xo[0] == xo[3] && xo[3] == xo[6]) {
      setState(() {
        result = 'Player ' + xo[0] + ' wins';
        matchIndex.addAll([0, 3, 6]);
        stopTimer();
        updateScore(xo[0]);
      });
    }
    if (!winnerFound && xo[0] != '' && xo[0] == xo[4] && xo[4] == xo[8]) {
      setState(() {
        result = 'Player ' + xo[0] + ' wins';
        matchIndex.addAll([0, 4, 8]);
        stopTimer();
        updateScore(xo[0]);
      });
    }
    if (!winnerFound && xo[1] != '' && xo[1] == xo[4] && xo[4] == xo[7]) {
      setState(() {
        result = 'Player ' + xo[1] + ' wins';
        matchIndex.addAll([4, 1, 7]);
        stopTimer();
        updateScore(xo[1]);
      });
    }
    if (!winnerFound && xo[2] != '' && xo[2] == xo[5] && xo[5] == xo[8]) {
      setState(() {
        result = 'Player ' + xo[2] + ' wins';
        matchIndex.addAll([8, 5, 2]);
        stopTimer();
        updateScore(xo[2]);
      });
    }
    if (!winnerFound && xo[2] != '' && xo[2] == xo[4] && xo[4] == xo[6]) {
      setState(() {
        result = 'Player ' + xo[2] + ' wins';
        matchIndex.addAll([6, 4, 2]);
        stopTimer();
        updateScore(xo[2]);
      });
    }
    if (!winnerFound && xo[3] != '' && xo[3] == xo[4] && xo[5] == xo[4]) {
      setState(() {
        result = 'Player ' + xo[3] + ' wins';
        matchIndex.addAll([3, 5, 4]);
        stopTimer();
        updateScore(xo[3]);
      });
    }
    if (!winnerFound && xo[6] != '' && xo[6] == xo[7] && xo[7] == xo[8]) {
      setState(() {
        result = 'Player ' + xo[6] + ' wins';
        matchIndex.addAll([6, 7, 8]);
        stopTimer();
        updateScore(xo[6]);
      });
    } else if (!winnerFound && filledBoxes == 9) {
      setState(() {
        result = 'Game Draw';
        stopTimer();
      });
    }
  }

  void updateScore(String winner) {
    if (winner == 'O')
      oScore++;
    else if (winner == 'X') xScore++;
    winnerFound = true;
  }

  flushBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) xo[i] = '';
      result = '';
    });
    filledBoxes = 0;
    winnerFound = false;
  }

  Widget buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Text(
                    '$seconds',
                    style: font1,
                  ),
                ),
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: AlwaysStoppedAnimation(AppColor.accentColor),
                  strokeWidth: 10,
                  backgroundColor: AppColor.secondaryColor,
                )
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              attempt++;
              matchIndex.clear();
              startTimer();
              flushBoard();
            },
            child: Text(
              attempt == 0 ? 'Start >>' : 'Play Again',
              style: font1,
            ),
            style: ElevatedButton.styleFrom(
                elevation: 10,
                backgroundColor: AppColor.secondaryColor,
                side: BorderSide(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10)));
  }
}
