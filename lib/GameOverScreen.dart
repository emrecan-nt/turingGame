import 'package:flutter/material.dart';
import 'package:turing_game/UsernameScreen.dart';

class GameOverScreen extends StatelessWidget {
  final int score;
  final Duration duration;
  GameOverScreen({required this.score, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
      backgroundColor: Colors.yellow.shade200,
        title: Text('Oyun Bitti'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Skorunuz: $score', style: TextStyle(fontSize: 32,fontStyle: FontStyle.italic)),
            Text('Süre: ${duration.inSeconds}s',
                style: TextStyle(fontSize: 24,fontStyle: FontStyle.italic)),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UsernameScreen()),
                );
                
              },
              child: Text('Tekrar Oyna',
              style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black),
              
              ),
              style:ElevatedButton.styleFrom(
              backgroundColor: Colors.amber.shade300,
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15)
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(padding: EdgeInsets.all(8),
      child: Text('Developed by Emre Mızrak © 2024',
      style: TextStyle(fontSize: 12,color: Colors.black),
      textAlign: TextAlign.center,
      ),
      ),
    );
  }
}
