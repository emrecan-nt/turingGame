import 'package:flutter/material.dart';

class YouWinScreen extends StatefulWidget {
  final int score;
  final Duration duration;

  const YouWinScreen({Key? key, required this.score, required this.duration}) : super(key: key);

  @override
  _YouWinState createState() => _YouWinState();
}

class _YouWinState extends State<YouWinScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward().whenComplete(() {
        setState(() {
          _opacity = 1.0;
        });
      });

    _animation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: Text('Sen Kazandın!'),
         backgroundColor: Colors.yellow.shade200,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: _animation.value,
            child: Opacity(
              opacity: _opacity,
              child: Icon(
                Icons.star,
                size: 80,
                color: Colors.yellow,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            child: Opacity(
              opacity: _opacity,
              child: Icon(
                Icons.favorite_border_rounded,
                size: 60,
                color: Colors.pink,
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 50,
            child: Opacity(
              opacity: _opacity,
              child: Icon(
                Icons.favorite,
                size: 60,
                color: Colors.red,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tebrikler! Tüm soruları doğru bildiniz!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black,fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Puan: ${widget.score}',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  'Süre: ${widget.duration.inSeconds} saniye',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
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
