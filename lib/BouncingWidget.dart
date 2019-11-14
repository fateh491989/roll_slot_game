import 'package:flutter/material.dart';

class BouncingWidget extends StatefulWidget {
  BouncingWidget({this.animation,this.text, this.height, this.width});
  final Animation animation;
  final String text;
  final double height;
  final double width;
  @override
  _BouncingWidgetState createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget> {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: widget.animation.value,
      child: Container(
                    height: widget.height,
                    width:  widget.width,
                    margin: EdgeInsets.all(10),
                    color: Colors.blue,
                    child: Center(child: Text(widget.text)),
                  ),
    );
  }
}
