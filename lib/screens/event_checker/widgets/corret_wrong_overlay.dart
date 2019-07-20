import 'package:flutter/material.dart';
import 'dart:math';

class CorrectWrongOverlay extends StatefulWidget {
  final bool _isCorrect;
  final String _message;
  final VoidCallback _onTap;

  const CorrectWrongOverlay(
    this._isCorrect, 
    this._message,
    this._onTap
  );

  @override
  _CorrectWrongOverlayState createState() => _CorrectWrongOverlayState();
}

class _CorrectWrongOverlayState extends State<CorrectWrongOverlay> with SingleTickerProviderStateMixin {
  
  Animation<double> _iconAnimation;   //> This will increment from 0 to 1 progressively
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );

    _iconAnimation = CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.elasticOut // Animation increments type
    );
    _iconAnimation.addListener(() => this.setState((){}));

    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget._isCorrect 
        ? Color.fromARGB(128, 165, 214, 167)
        : Color.fromARGB(128, 239, 154, 154),
      child: InkWell(
        onTap: widget._onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: Transform.rotate(
                angle: _iconAnimation.value * 2 * pi,
                child: Icon(
                  widget._isCorrect ? Icons.done: Icons.clear,
                  size: 80.0 * _iconAnimation.value,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget._isCorrect ? "Ok!" : "Error",
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 30.0
                  ),
                ),
                Text(
                  widget._message,
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 30.0
                  ),
                )
              ],
            )
          ],
        )
      ),
      
    );
  }
}