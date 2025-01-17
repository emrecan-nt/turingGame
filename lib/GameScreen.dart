import 'dart:async';
import 'package:flutter/material.dart';
import 'package:turing_game/GameOverScreen.dart';

import 'dart:math';

import 'package:turing_game/YouWinScreen.dart';

class GameScreen extends StatefulWidget {
  final String username;
  GameScreen({required this.username});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> aiImages =
      List.generate(27, (index) => 'assets/ai/${index + 1}.png');
  final List<String> humanImages =
      List.generate(28, (index) => 'assets/human/${index + 1}.jpg');
  String currentImage = '';
  bool yapay = false;
  int skor = 0;
  int hata = 0;
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    stopwatch.start();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
    loadNextImage();
  }

  @override
  void dispose() {
    timer.cancel();
    stopwatch.stop();
    super.dispose();
  }

  void loadNextImage() {
  if (skor >= 40) {
    YouWin();
    return; 
  }

  final random = Random();
  final useAiImage = random.nextBool();

  if (useAiImage && aiImages.isNotEmpty) {
    currentImage = aiImages[random.nextInt(aiImages.length)];
    yapay = true;

    aiImages.remove(currentImage);
  } else if (humanImages.isNotEmpty) {
    currentImage = humanImages[random.nextInt(humanImages.length)];
    yapay = false;

    humanImages.remove(currentImage);
  } else {
    if (skor >= 40) {
      YouWin();
    } else {
      gameOver();
    }
  }

  setState(() {});
}
  void checkAnswer(bool userSelectedAi) {
    if (userSelectedAi == yapay) {
      skor++;
    } else {
      hata++;
      if (hata >= 3) {
        gameOver();
        return;
      }
    }
    loadNextImage();
  }

  void gameOver() {
    stopwatch.stop();
    timer.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            GameOverScreen(score: skor, duration: stopwatch.elapsed),
      ),
    );
  }
  void YouWin() {
    stopwatch.stop();
    timer.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            YouWinScreen(score: skor, duration: stopwatch.elapsed),
      ),
    );
  }

  String formatElapsedTime(Duration elapsed) {
    String minutes = elapsed.inMinutes.toString().padLeft(2, '0');
    String seconds = (elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: Text(
          'Turing Game - ${widget.username}',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.yellow.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Skor: $skor',
                  style: TextStyle(
                    fontSize: 26,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Row(
                  children: List.generate(
                    3,
                    (index) => Icon(
                      index < (3 - hata)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (currentImage.isNotEmpty)
                    Image.asset(currentImage, height: 300),
                  SizedBox(height: 16),
                  Text(
                    'Zaman: ${formatElapsedTime(stopwatch.elapsed)}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => checkAnswer(true),
                        child: Text('Yapay Zeka'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade300,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => checkAnswer(false),
                        child: Text('İnsan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade300,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Developed by Emre Mızrak © 2024',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


